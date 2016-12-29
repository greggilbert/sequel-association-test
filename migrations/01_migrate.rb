Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :email, null: false
      String :password_hash, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    create_table(:vendors) do
      primary_key :id
      foreign_key :user_id, :users
      Boolean :is_verified, default: false
    end

    create_table(:vendor_revisions) do
      primary_key :id
      foreign_key :vendor_id, :vendors, null: false, index: true
      String :name, null: false, index: true
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end

    alter_table(:vendors) do
      add_foreign_key :latest_revision, :vendor_revisions, null: true
    end
  end

  down do
    alter_table(:vendors) do
      drop_foreign_key :latest_revision
    end
    drop_table(:vendor_revisions)
    drop_table(:vendors)
    drop_table(:users)
  end
end
