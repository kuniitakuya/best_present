class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.string :message_image
      t.string :select_item, null: false
      t.references :user, foreign_key: true
      t.references :wish_list, foreign_key: true

      t.timestamps
    end
  end
end
