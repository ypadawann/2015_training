class CreateTimecards < ActiveRecord::Migration
  def change
    create_table :timecards do |t|
      t.date :day
      t.integer :user_id
      t.string :attendance, limit: 10
      t.string :leaving, limit: 10
      t.string :prearranged_holiday, limit: 15
      t.float :paid_vacation
      t.string :holiday_acquisition, limit: 15
      t.string :etc, limit: 50
    end
    add_foreign_key(:timecards, :users, column: 'user_id')
  end
end
