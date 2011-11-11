class AddBookingDateToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :booking_date, :datetime
    
      Booking.all.each do |booking|
        booking.booking_date = booking.created_at
        booking.save
      end
  end

  def self.down
    remove_column :bookings, :booking_date
  end
end
