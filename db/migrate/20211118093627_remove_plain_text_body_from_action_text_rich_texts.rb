class RemovePlainTextBodyFromActionTextRichTexts < ActiveRecord::Migration[6.1]
  def change
    remove_column :action_text_rich_texts, :plain_text_body, :text
  end
end
