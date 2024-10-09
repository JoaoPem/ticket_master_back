class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false
      t.references :department, foreign_key: true, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
