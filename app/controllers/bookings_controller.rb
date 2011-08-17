class BookingsController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :meetingroom , :optional => true
  before_filter :get_news
  
  def new
    new!
 #   @booking.endtime = @booking.starttime + 10
    
  end
  
  def index 
    @bookings = Booking.order('starttime asc').paginate(:per_page => 24, :page => params[:page])
    @meetingroom = Meetingroom.first
    if request.xhr?
      @date = Date.parse params[:date]
      render '_calendar', layout => false
    end
  end
  
  def create
    session[:go_to_after_edit] = nil
    @meetingroom = Meetingroom.first
    create! { new_meetingroom_booking_path(@meetingroom)}
    
  end
  
  def update

    session[:go_to_after_edit] = nil
    @meetingroom = Meetingroom.first
    update! { new_meetingroom_booking_path(@meetingroom)}
  end
  

  
end
