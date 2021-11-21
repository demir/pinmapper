class TsvectorTriggerBoardsInsertUpdate < ActiveRecord::Migration[6.1]
  def up
    add_column :boards, :tsv, :tsvector
    add_index :boards, :tsv, using: 'gin'

    execute <<-SQL
      CREATE OR REPLACE  FUNCTION update_boards_tsv() RETURNS trigger AS $$
      BEGIN
        NEW.tsv := (
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.name,'')), 'A')
        );
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON boards FOR EACH ROW EXECUTE PROCEDURE update_boards_tsv();
    SQL

    update('UPDATE boards SET name = name;')
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON boards;
      DROP FUNCTION update_boards_tsv();
    SQL

    remove_index :boards, :tsv
    remove_column :boards, :tsv
  end
end
