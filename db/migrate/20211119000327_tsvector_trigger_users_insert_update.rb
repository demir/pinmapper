class TsvectorTriggerUsersInsertUpdate < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :tsv, :tsvector
    add_index :users, :tsv, using: 'gin'

    execute <<-SQL
      CREATE OR REPLACE  FUNCTION update_users_tsv() RETURNS trigger AS $$
      BEGIN
        NEW.tsv := (
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.username,'')), 'A')
        );
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON users FOR EACH ROW EXECUTE PROCEDURE update_users_tsv();
    SQL

    update('UPDATE users SET username = username;')
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON users;
      DROP FUNCTION update_users_tsv();
    SQL

    remove_index :users, :tsv
    remove_column :users, :tsv
  end
end
