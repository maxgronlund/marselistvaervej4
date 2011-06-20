class BookingcalendarController < ApplicationController
  
  def index
    session[:go_to_after_edit] = bookingcalendar_index_path()
    @meetingrooms = Meetingroom.all
  end

end
