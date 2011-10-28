class AdminGalleriesController < ApplicationController
  
  def new
    @gallery = Gallery.find(params[:gallery])
    @photo  = @gallery.photos.create(params[:id])
    @photo.save
  end
  
#  def update
#    @gallery = Gallery.find(params[:gallery])
#    @photo  = @gallery.photos.find(params[:id])
#    @photo.save
#  end
  
  def show
    @gallery = Gallery.find(params[:id])
  end

end
