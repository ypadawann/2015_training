class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.integer :id, null: false
      t.string :name, null: false, limit: 50
      t.integer :department_id, null: false
      t.string :password, null: false
    end
    add_foreign_key(:users, :departments)
    execute 'ALTER TABLE users ADD PRIMARY KEY (id)'
  end
end
