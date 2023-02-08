class AddColumnItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :save_list, :string, null: false
  end
end
