# encoding: utf-8
class Blog < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :body
#  belongs_to :commentable, :polymorphic => true

  scope :language, lambda { where(:language => I18n.locale.to_s) }

#  define_index do
#    indexes :title
#    indexes :body
#    indexes :language
#  end



  

end
