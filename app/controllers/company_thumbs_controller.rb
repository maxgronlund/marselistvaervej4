class CompanyThumbsController < InheritedResources::Base
  
  belongs_to :company , :optional => true
  

  def update
    @company = Company.find(params[:company_id])
    @company_thumb = @company.company_thumbs.find(params[:id])
    
    if @company_thumb.update_attributes(params[:company_thumb])
      if params[:company_thumb][:image].blank?
        flash[:notice] = "Successfully updated company."
        @company_thumb.image.reprocess! if params[:company_thumb][:crop_x]
        redirect_to @company_thumb.company
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end


  def create

    @company = Company.find(params[:company_id])
    @company_thumb = @company.company_thumbs.create(params[:company_thumb])
    if @company_thumb.save
      if params[:company_thumb].nil? or params[:company_thumb][:image].blank?
        flash[:notice] = "Successfully created company."
        redirect_to company_path(@company_thumb.company)
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end

  def crop
#    @company = Company.find(params[:company_id])
#    @company_thumb = @company.company_thumbs.find(params[:id])
  end
  
#  def update
#    update! {company_path(@company_thumb.company)}
#  end

end
