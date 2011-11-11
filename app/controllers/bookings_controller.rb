class BookingsController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :meetingroom , :optional => true
  before_filter :get_internal_news
    helper_method :sort_column, :sort_direction 
  
  def index
    @bookings = Booking.scoped
    @bookings = @bookings.after(Time.at(params['start'].to_i)) if (params['start'])
    @bookings = @bookings.before(Time.at(params['end'].to_i)) if (params['end'])
    @bookings = @bookings.order(sort_column + ' ' + sort_direction).paginate(:per_page => 24, :page => params[:page]) unless params['start'] or params['end']
    @meetingroom ||= Meetingroom.first

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
      format.js  { render :json => @bookings }
    end
  end
  
  def new
    @booking = Booking.new
    @booking.booking_date = params[:date].present?? params[:date].to_date : Date.today
    @booking.starttime = Time.now
    @booking.endtime = @booking.starttime + 1.hour
    new!
  end
  
  def create
    session[:go_to_after_edit] = nil
    @meetingroom = Meetingroom.find(params[:booking][:meetingroom_id])#Meetingroom.first
    @booking.meetingroom = @meetingroom
    create! { new_meetingroom_booking_path(@meetingroom, :date => @booking.booking_date)}
  end
  
  def update
    session[:go_to_after_edit] = nil
    @meetingroom = Meetingroom.find(params[:booking][:meetingroom_id])#Meetingroom.first
    @booking.meetingroom = @meetingroom
    update! { new_meetingroom_booking_path(@meetingroom, :date => @booking.booking_date)}
  end
  

  
private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "booking_date"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"  
  end
end
