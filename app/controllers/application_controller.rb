# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
 before_filter :set_locale
 
 def after_sign_in_path_for(resource)
   if current_user.admin_or_super?
     #admin_path
     @meeting_room = Meetingroom.first
     new_meetingroom_booking_path(@meeting_room)
   else
     user_path(resource)
   end
 end
 
  def set_locale
   I18n.locale = 'dk'
#     if user_signed_in?
#       I18n.locale = session[:locale] || current_user.language
#     else
#       #I18n.locale = 'dk'
#       I18n.locale = session[:locale] || 'en'
#     end
  end
 
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  def get_news
    @newsposts = Newspost.external.order('created_at desc').paginate(:per_page => 3, :page => params[:page])
  end
  
  def get_first_meeting_room
    @first_meeting_room = Meetingroom.first
  end
  
  def get_internal_news
    @newsposts = Newspost.internal.order('created_at desc').paginate(:per_page => 3, :page => params[:page])
  end
 
private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 
  
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end

  
end
