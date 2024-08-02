struct CreateUserProjectPivotMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(UserProjectPivot.schema)
        .id()
        .field(.UserProjectPivotKey.projectId, .uuid, .required,
               .references(Project.schema, "id", onDelete: .cascade))
        .field(.UserProjectPivotKey.userId, .uuid, .required,
               .references(User.schema, "id", onDelete: .cascade))
        .field(.UserProjectPivotKey.roleId, .uuid, .required, .references(ProjectRole.schema, "id", onDelete: .cascade))
        .unique(on: .UserProjectPivotKey.projectId, .UserProjectPivotKey.userId, name: ConstraintName.uniqueUserRoleProject)
        .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(UserProjectPivot.schema).delete()
    }
}
