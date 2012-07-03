# encoding: utf-8
class PagesController < InheritedResources::Base
  load_and_authorize_resource
  #uses_tiny_mce :only => [:new, :create, :edit, :update]
  
  helper_method :sort_column, :sort_direction
  
  def index
    session[:go_to_after_edit] = pages_path
    @pages = Page.order(sort_column + ' ' + sort_direction).paginate(:per_page => 25, :page => params[:page])
  end
  
  def update
    goto = session[:go_to_after_edit] || pages_path
    session[:go_to_after_edit] = nil
    update! {goto}
  end
  
  def create
    create!{pages_path}
  end
  
  
  
private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end
