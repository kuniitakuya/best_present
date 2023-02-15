class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.string :image, null: false
      t.references :user, null: false, foreign_key: true
      t.references :wish_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
