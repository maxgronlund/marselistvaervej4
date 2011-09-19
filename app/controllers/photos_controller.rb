class PhotosController < InheritedResources::Base
     before_filter :get_internal_news
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.image_content_type = MIME::Types.type_for(@photo.image.original_filename).first.to_s if @photo.image.original_filename.present?
    if @photo.save
      if params[:photo][:image].blank?
        flash[:notice] = "Successfully created photo."
        redirect_to photos_path
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      if params[:photo][:image].blank?
        flash[:notice] = "Successfully updated photo."
        redirect_to photos_path
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
   
   def crop
     # nothing here
   end
   
end
