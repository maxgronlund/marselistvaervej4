class PhotosController < InheritedResources::Base

  load_and_authorize_resource
  before_filter :get_internal_news
  belongs_to :gallery , :optional => true
  
  def show
    logger.debug '++++++++++++++++++++++++++++++++++++++++++++++'
     @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to :back
  end

  
  def create
    
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.create(params[:photo])
    @photo.image_content_type = MIME::Types.type_for(@photo.image.original_filename).first.to_s if @photo.image.original_filename.present?
    if @photo.save
      if params[:photo][:image].blank?
        flash[:notice] = "Successfully created photo."
        redirect_to admin_gallery_path(@gallery) 
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
        redirect_to admin_gallery_path(@photo.gallery_id) 
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
  
  def destroy
    logger.debug '************************************************************'
    go_to = admin_gallery_path(@photo.gallery_id)
    destroy! { go_to}
  end
  
end
