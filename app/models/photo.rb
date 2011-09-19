# encoding: utf-8
class Photo < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :image,:crop_x, :crop_y, :crop_w, :crop_h, :title, :body
  
  has_attached_file :image, 
                    :styles => {  :micro => "60x45#",:mini => "100x75#", :fullSize => "540x405#" }, 
                    :processors => [:cropper],
                    :default_url => "/images/fallback/default_avatar_:style.jpg"
                    
  validates_attachment_size :image, :less_than => 3.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png','image/gif']
  
  after_update :reprocess_image, :if => :cropping?
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  
  def cropping?
     !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
   end

   def image_geometry(style = :original)
     @geometry ||= {}
     @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
   end

   def reprocess_image
     image.reprocess!
   end
  

  
end
