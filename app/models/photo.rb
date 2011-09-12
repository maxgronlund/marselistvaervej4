# encoding: utf-8
class Photo < ActiveRecord::Base
  
  has_attached_file :image, 
                    :styles => {  :mini => "75x75#", :fullSize => "540x490>" }, 
                    :default_url => "/images/fallback/default_illustration_:style.gif"
                    
  validates_attachment_size :image, :less_than => 3.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png','image/gif']
  

  
end
