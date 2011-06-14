# encoding: utf-8
class MeetingroomsController < InheritedResources::Base
  load_and_authorize_resource
  
  

  def update

    @meetingroom = Meetingroom.find(params[:id])
    if @meetingroom.update_attributes(params[:meetingroom])
      if params[:meetingroom][:image].blank?
        flash[:notice] = "Successfully updated meetingroom."
        redirect_to @meetingroom
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end

  
  def create

    @meetingroom = Meetingroom.new(params[:meetingroom])
    if @meetingroom.save
      if params[:meetingroom][:image].blank?
        flash[:notice] = "Successfully created meetingroom."
        redirect_to meetingroom_path(@meetingroom)
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end
  
  def show
    session[:go_to_after_edit] = meetingroom_path(@meetingroom)
    show!
  end
  

  
  def crop
    
  end
    
private


  
  
end
