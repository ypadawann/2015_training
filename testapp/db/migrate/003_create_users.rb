class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: 'num' do |t|
      t.integer :id, null: false
      t.string :name, null: false, limit: 50
      t.integer :department_id, null: false
      t.string :password, null: false
      t.date :enter, null: false
    end
    add_foreign_key(:users, :departments)
  end
end
