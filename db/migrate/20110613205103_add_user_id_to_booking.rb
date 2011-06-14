class AddUserIdToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :user_id, :integer

  end

  def self.down
    remove_column :bookings, :user_id
  end
end
