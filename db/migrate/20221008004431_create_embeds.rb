class CreateEmbeds < ActiveRecord::Migration[7.0]
  def change
    create_table :embeds do |t|
      t.string :url
      t.boolean :video
      t.text :html
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
