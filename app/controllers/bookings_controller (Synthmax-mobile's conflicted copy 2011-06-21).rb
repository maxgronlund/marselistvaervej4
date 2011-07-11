class BookingsController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :meetingroom , :optional => true
  
  def new

      @meetingrooms = Meetingroom.order('title DESC')
      @select_meetingroom = @meetingrooms.map { |meetingrooms| [meetingrooms.title, meetingrooms.id] }
      @booking.attendees = 4
      
      if(current_user.role == 'member' )  
        @user = current_user
      else
        @user = User.order('name DESC')
        @select_user = @user.map { |user| [user.name, user.name] }
      end
   end
   
  def edit
      @meetingrooms = Meetingroom.order('title DESC')
      @select_meetingroom = @meetingrooms.map { |meetingrooms| [meetingrooms.title, meetingrooms.id] }
  
      if(current_user.role == 'member' )  
        @user = current_user
      else
        @user = User.order('name DESC')
        @select_user = @user.map { |user| [user.name, user.name] }
      end
  end
   
  def index
    index!
    session[:go_to_after_edit] = meetingroom_bookings_path(@meetingroom)
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
