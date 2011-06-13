# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  
  #!!! if registerable is enabled all can signup and admin can't create accounts
  #!!! when registeerable is enabled links to signup has to be enabled
  
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, 
                  :name, :image, :language,:crop_x, :crop_y, :crop_w, :crop_h,
                  :grid
  has_many :blogs
  has_many :comments
  
  validates_presence_of :name          
  after_update :reprocess_image, :if => :cropping?
  
  has_attached_file :image, 
                    :styles => {  :micro => "25x25#", :small => "50x50#", :medium => "238x280#", :large => "754x887>"}, 
                    :processors => [:cropper],
                    :default_url => "/images/fallback/default_avatar_:style.jpg"
                    
  
  after_update :reprocess_image, :if => :cropping?
  
  
  #, :default_url => "/images/fallback/default_avatar_:style.png"
  
  validates_attachment_size :image, :less_than => 8.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png','image/gif'],:message => 'must be a URL for GIF, JPG or PNG image.'
  
  
  ROLES = %w[member admin super]
  LANGUAGE = [['Dansk', 'dk'], ['English','en']]
  
  def admin_or_super?
    admin? || super?
  end
  
  def super?
    role == 'super'
  end
  
  def admin?
    role == 'admin'
  end
  
  def member?
    role == 'member'
  end
  
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
