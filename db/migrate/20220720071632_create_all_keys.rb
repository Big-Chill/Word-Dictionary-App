class CreateAllKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :all_keys do |t|
      t.string :api_key
      t.integer :frequency
      t.timestamps
    end
  end
end
