class CreateAllWords < ActiveRecord::Migration[7.0]
  def change
    create_table :all_words do |t|
      t.string :word_name
      t.timestamps
    end
  end
end
