class InfoPagesController < InheritedResources::Base
  before_filter :get_news
  helper_method :sort_column, :sort_direction
  #uses_tiny_mce :only => [:new, :create, :edit, :update]
    
private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
