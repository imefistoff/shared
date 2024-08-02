final class FieldModel: Model, Content, @unchecked Sendable {
    static let schema = "entity_fields"

    @ID(key: .id)
    var id: UUID?

    @Field(key: .FieldModelKey.name)
    var name: String

    @Field(key: .FieldModelKey.type)
    var type: String
    
    @Field(key: .FieldModelKey.properties)
    var properties: [String: AnyCodable]?

    @Parent(key: .FieldModelKey.entityID)
    var entity: EntityModel

    init() {}

    init(id: UUID? = nil,
         name: String,
         type: String,
         properties: [String: AnyCodable]? = nil,
         entityID: EntityModel.IDValue) {
        self.id = id
        self.name = name
        self.type = type
        self.properties = properties
        self.$entity.id = entityID
    }
}
