class BookingsController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :meetingroom , :optional => true
  
  def index
    if request.xhr?
      @date = Date.parse params[:date]
      render '_calendar', layout: false
    end
    #session[:go_to_after_edit] = meetingroom_bookings_path(@meetingroom)
  end
  
  def create
    
    goto = session[:go_to_after_edit] || bookings_path
    session[:go_to_after_edit] = nil
    create! {goto}
    
  end
  
  def update
    goto = session[:go_to_after_edit] || bookings_path
    session[:go_to_after_edit] = nil
    update! {goto}
  end
  
  def destroy
    goto = session[:go_to_after_edit] || bookings_path
    session[:go_to_after_edit] = nil
    destroy! {goto}
  end
  
  
end
