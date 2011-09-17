class PhotosController < InheritedResources::Base
  
  
  def create  
    @photo = Photo.new(params[:photo])
    @photo.image_content_type = MIME::Types.type_for(@photo.image.original_filename).first.to_s if @photo.image.original_filename.present?
    @photo.save
    create! {photo_path(@photo)}
  end
  
  def update

    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      if params[:photo][:image].blank?
        flash[:notice] = "Successfully updated photo."
        redirect_to @photo
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
   
   def crop

   end
   
end
