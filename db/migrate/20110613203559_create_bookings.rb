class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.integer :meetingroom_id
      t.time :starttime
      t.time :endtime
      t.integer :attendees
      t.boolean :coffee_and_bread
      t.string :bookers_name

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
