class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins, primary_key: 'num' do |t|
      t.string :id, null: false, limit: 50
      t.string :password, null: false
    end
  end
end
