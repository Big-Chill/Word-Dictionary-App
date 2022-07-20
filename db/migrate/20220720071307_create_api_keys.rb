class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :api_key
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
