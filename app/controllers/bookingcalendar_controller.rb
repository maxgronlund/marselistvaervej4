class BookingcalendarController < ApplicationController
  
  before_filter :get_internal_news
  
  def index
    session[:go_to_after_edit] = bookingcalendar_index_path()
    @meetingrooms = Meetingroom.all
  end

end
