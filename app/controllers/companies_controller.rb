class CompaniesController < InheritedResources::Base
  load_and_authorize_resource
  uses_tiny_mce :only => [:new, :create, :edit, :update]
  before_filter :get_news
  
  def index
    session[:go_to_after_edit] = companies_path
    @companies = Company.order('title asc').paginate(:per_page => 8, :page => params[:page])
  end


  def update

    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      if params[:company][:image].blank?
        flash[:notice] = "Successfully updated company."
        redirect_to @company
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end


  def create

    @company = Company.new(params[:company])
    if @company.save
      if params[:company][:image].blank?
        flash[:notice] = "Successfully created company."
        redirect_to company_path(@company)
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end



  def crop

  end

end

