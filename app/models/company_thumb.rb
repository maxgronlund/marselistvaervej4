class CompanyThumb < ActiveRecord::Base
  
  belongs_to :company
  
  has_attached_file :image, 
                    :styles => { :mini => "70x57#",:thumbnail => "140x114#", :preview => "460x376#",:xxl => "754x616>" }, 
                    :processors => [:cropper],
                    :default_url => "/images/fallback/default_illustration_:style.gif",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"

                    validates_attachment_size :image, :less_than => 8.megabytes
                    #validates_attachment_content_type :image, :content_type => ['image/jpeg',
                    #                                                            'image/jpg',
                    #                                                            'image/png',
                    #                                                            'image/x-png',
                    #                                                            'image/gif',
                    #                                                            'image/pjpeg'],:message => 'must be a URL for GIF, JPG or PNG image.'
  #after_update :reprocess_image, :if => :cropping?

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


  def cropping?
     !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
   end

   def image_geometry(style = :original)
     @geometry ||= {}
     @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
   end

   #def reprocess_image
   #  image.reprocess!
   #end
   
end
