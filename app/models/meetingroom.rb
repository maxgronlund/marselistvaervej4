class Meetingroom < ActiveRecord::Base
  has_many :bookings
  
  validates :title, :presence => true
  validates :body, :presence => true
  
  has_attached_file :image, 
                    :styles => { :mini => "70x57>",:thumbnail => "140x114#", :preview => "460x376#",:xxl => "754x616>" }, 
                    :processors => [:cropper],
                    :default_url => "/images/fallback/default_illustration_:style.gif"
  
                    validates_attachment_size :image, :less_than => 8.megabytes
                    validates_attachment_content_type :image, :content_type => ['image/jpeg',
                                                                                'image/jpg',
                                                                                'image/png',
                                                                                'image/x-png',
                                                                                'image/gif',
                                                                                'image/pjpeg'],:message => 'must be a URL for GIF, JPG or PNG image.'
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

  def available?(date, starttime, endtime, booking)
    (booking.new_record?? bookings : bookings.except_this(booking)).
      for_day(date).overlapping(starttime, endtime).none?
  end

end
