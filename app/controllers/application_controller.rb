# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
 before_filter :set_locale
 
 
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
    @newsposts = Newspost.order('created_at desc').paginate(:per_page => 3, :page => params[:page])
   
  end
 
private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 
  
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end

  
end
