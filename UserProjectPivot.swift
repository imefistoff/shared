final class UserProjectPivot: Model, Content, @unchecked Sendable {
    static let schema = "user+project+pivot"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: .UserProjectPivotKey.projectId)
    var project: Project
    
    @Parent(key: .UserProjectPivotKey.userId)
    var user: User
    
    @Parent(key: .UserProjectPivotKey.roleId)
    var role: ProjectRole
    
    init() {}
    
    init(id: UUID? = nil,
         user: User.IDValue,
         project: Project.IDValue,
         role: ProjectRole.IDValue) {
        self.id = id
        self.$user.id = user
        self.$project.id = project
        self.$role.id = role
    }
}
