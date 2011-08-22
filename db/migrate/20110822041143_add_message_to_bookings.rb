class AddMessageToBookings < ActiveRecord::Migration
  def self.up
    remove_column :bookings, :coffee_and_bread
    
    add_column :bookings, :custom_message, :string
    add_column :bookings, :coffee_and_tea, :boolean
    add_column :bookings, :bread, :boolean
  end

  def self.down
    add_column :bookings, :coffee_and_bread, :boolean
    remove_column :bookings, :custom_message
    remove_column :bookings, :coffee_and_tea
    remove_column :bookings, :bread
  end
end
