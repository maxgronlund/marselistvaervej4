class NewspostsController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :get_news
  helper_method :sort_column, :sort_direction


  def index
    @newsposts = Newspost.order(sort_column + ' ' + sort_direction).paginate(:per_page => 25, :page => params[:page])
  end
  
  def update
    goto = session[:go_to_after_edit] || newsposts_path
    session[:go_to_after_edit] = nil
    update! {goto}
  end



private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end

