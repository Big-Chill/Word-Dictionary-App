class AddCreatedTimeToAllkeys < ActiveRecord::Migration[7.0]
  def change
    add_column :all_keys, :created_time, :datetime
  end
end
