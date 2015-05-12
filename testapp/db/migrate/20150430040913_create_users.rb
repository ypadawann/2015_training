class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.integer :department_id, null: false
      t.string :password, null: false
    end
    add_foreign_key(:users, :departments) #, column: 'department')
  end
end
