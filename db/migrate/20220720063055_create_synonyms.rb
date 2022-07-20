class CreateSynonyms < ActiveRecord::Migration[7.0]
  def change
    create_table :synonyms do |t|
      t.string :text
      t.belongs_to :all_word, index: true, foreign_key: true

      t.timestamps
    end
  end
end
