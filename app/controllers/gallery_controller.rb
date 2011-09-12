class GalleryController < ApplicationController
  def index
    @gallery = Photo.all
  end

end
