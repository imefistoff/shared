final class ProjectRole: Model, Content, @unchecked Sendable {
    static let schema = "project_roles"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .ProjectRoleKey.roleName)
    var title: String
    
    init() {}
    
    init(id: UUID? = nil,
         title: String) {
        self.id = id
        self.title = title
    }
}
