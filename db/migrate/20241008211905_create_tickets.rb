class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :status, null: false, default: 'new'
      t.references :creator, foreign_key: { to_table: :users }, null: false
      t.references :requester, foreign_key: { to_table: :users }, null: false
      t.references :assigned_user, foreign_key: { to_table: :users }, null: true
      t.references :department, foreign_key: true, null: false
      t.integer :priority, null: false, default: 0
      t.timestamps
    end
  end
end
