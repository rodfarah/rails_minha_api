class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :is_active, default: true, null: false
      t.string :role, default: "user", null: false
      t.integer :gender

      t.timestamps
    end
  end
end
