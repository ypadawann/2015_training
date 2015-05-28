class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name, null: false, limit: 50
      t.string :password, null: false
    end
  end
end
