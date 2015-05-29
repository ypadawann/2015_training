class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins, id: false do |t|
      t.string :id, null: false, limit: 50
      t.string :password, null: false
    end
    execute 'ALTER TABLE admins ADD PRIMARY KEY (id)'
  end
end
