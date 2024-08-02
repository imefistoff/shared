final class Project: Model, Content, @unchecked Sendable {
    static let schema = "projects"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .ProjectKey.title)
    var title: String
    
    @Field(key: .ProjectKey.config)
    var config: [String: AnyCodable]
    
    @Parent(key: .ProjectKey.ownerId)
    var owner: User
    
    @Children(for: \.$project)
    var entities: [EntityModel]
    
    @Timestamp(key: .UserKey.createdAt, on: .create)
    var createdAt: Date?

    @Timestamp(key: .UserKey.updatedAt, on: .update)
    var updatedAt: Date?
    
    @Siblings(through: UserProjectPivot.self, from: \.$project, to: \.$user)
    var users: [User]
    
    init() {}
    
    init(id: UUID? = nil,
         title: String,
         config: [String: AnyCodable],
         ownerId: User.IDValue) {
        self.id = id
        self.title = title
        self.config = config
        self.$owner.id = ownerId
    }
}
