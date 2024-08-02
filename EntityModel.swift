final class EntityModel: Model, Content, @unchecked Sendable {
    static let schema = "entities"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .EntityModelKey.name)
    var name: String
    
    @Field(key: .EntityModelKey.properties)
    var properties: [String: AnyCodable]?
    
    @Parent(key: .EntityModelKey.projectId)
    var project: Project
    
    @Timestamp(key: .UserKey.createdAt, on: .create)
    var createdAt: Date?

    @Timestamp(key: .UserKey.updatedAt, on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$entity)
    var fields: [FieldModel]
    
    init() {}
    
    init(id: UUID? = nil,
         name: String,
         properties: [String: AnyCodable]? = nil,
         projectID: Project.IDValue) {
        self.id = id
        self.name = name
        self.properties = properties
        self.$project.id = projectID
    }
}
