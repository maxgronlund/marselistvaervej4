class NewspostsController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :get_news
  helper_method :sort_column, :sort_direction
  #uses_tiny_mce :only => [:new, :create, :edit, :update]


  def index
    @newsposts = Newspost.order(sort_column + ' ' + sort_direction).paginate(:per_page => 25, :page => params[:page])
  end

  
  def update

    @newspost = Newspost.find(params[:id])
    if @newspost.update_attributes(params[:newspost])
      if params[:newspost][:image].blank?
        flash[:notice] = "Successfully updated newspost."
        @newspost.image.reprocess! if params[:newspost][:crop_x]
        goto = session[:go_to_after_edit] || newsposts_path
        session[:go_to_after_edit] = nil
        update! {goto}
        
      #  redirect_to @company
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end


  def create

    @newspost = Newspost.new(params[:newspost])
    if @newspost.save
      if params[:newspost][:image].blank?
        flash[:notice] = "Successfully created company."
        redirect_to newspost_path(@newspost)
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end
  



private  
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end

