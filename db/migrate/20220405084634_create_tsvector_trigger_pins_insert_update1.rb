class CreateTsvectorTriggerPinsInsertUpdate1 < ActiveRecord::Migration[6.1]
  def up
    # remove old trigger
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON pins;
      DROP FUNCTION update_pins_tsv();
    SQL

    remove_index :pins, :tsv
    remove_column :pins, :tsv

    # add new trigger
    add_column :pins, :tsv, :tsvector
    add_index :pins, :tsv, using: 'gin'

    execute <<-SQL
      CREATE OR REPLACE  FUNCTION update_pins_tsv() RETURNS trigger AS $$
      BEGIN
        NEW.tsv := (
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.name,'')), 'A') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cover_photo_description,'')), 'B') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_user_username,'')), 'D') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_tag_list,'')), 'B') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_plain_text_description,'')), 'C')
        );
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON pins FOR EACH ROW EXECUTE PROCEDURE update_pins_tsv();
    SQL

    update('UPDATE pins SET name = name;')
  end

  def down
    # remove new trigger
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON pins;
      DROP FUNCTION update_pins_tsv();
    SQL

    remove_index :pins, :tsv
    remove_column :pins, :tsv

    # add old trigger
    add_column :pins, :tsv, :tsvector
    add_index :pins, :tsv, using: 'gin'

    execute <<-SQL
      CREATE OR REPLACE  FUNCTION update_pins_tsv() RETURNS trigger AS $$
      BEGIN
        NEW.tsv := (
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.name,'')), 'A') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cover_image_description,'')), 'B') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_user_username,'')), 'D') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_tag_list,'')), 'B') ||
          setweight(to_tsvector('pg_catalog.simple', coalesce(NEW.cached_plain_text_description,'')), 'C')
        );
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON pins FOR EACH ROW EXECUTE PROCEDURE update_pins_tsv();
    SQL

    update('UPDATE pins SET name = name;')
  end
end
