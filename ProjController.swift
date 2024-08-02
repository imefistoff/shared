@Sendable
    func getProjectsForUser(req: Request) async throws -> [CreateProjectResponse] {
        guard let userID = req.auth.get(UserTokenPayload.self)?.userID else {
            throw Abort(.unauthorized)
        }
        
        let projects = try await Project.query(on: req.db)
                .filter(\.$owner.$id == userID)
                .with(\.$entities) { modelQuery in
                    modelQuery.with(\.$fields)
                }
                .all()
        //TODO: updatel logic to fetch also user roles for all projects
            
        return try projects.compactMap(CreateProjectResponse.init)
    }
    
    @Sendable
    func getProjectByID(req: Request) async throws -> ProjectDTO {
        let projectID = req.parameters.get(PathIDs.projectID, as: UUID.self)
        
        guard let project = try await Project.find(projectID, on: req.db) else {
            throw Abort(.notFound, reason: "Project doesn't exist.")
        }
        
        try await project.$users.load(on: req.db)
        let userRolesInProject = try await UserProjectPivot
            .query(on: req.db)
            .filter(\UserProjectPivot.$project.$id == (try project.requireID()))
            .with(\.$role)
            .with(\.$user)
            .all()
            .map { ProjectUserDTO(userID: (try $0.user.requireID()),
                                  email: $0.user.email,
                                  role: $0.role.title) }
        
        let entities = try await project.$entities.query(on: req.db).with(\.$fields).all()
        
        return ProjectDTO(projectID: (try project.requireID()),
                          ownerID: project.$owner.id,
                          title: project.title,
                          entities: try entities.map(EntityModelDTO.init),
                          users: userRolesInProject,
                          createdAt: project.createdAt,
                          updatedAt: project.updatedAt)
    }
