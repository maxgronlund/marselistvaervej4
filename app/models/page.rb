# encoding: utf-8
class Page < ActiveRecord::Base
  

  scope :language, where(:language => I18n.locale.to_s)
  
  def self.with_identity(identity)
    where(:identity => identity).first
  end

  def self.welcome_dk 
    with_identity('welcome_dk ')
  end
  
  def self.welcome_en 
    with_identity('welcome_en')
  end
  
  def self.about_dk
    with_identity('about_dk')
  end
  
  def self.about_en
    with_identity('about_en')
  end
  
  def self.history_dk
    with_identity('history_dk')
  end
  
  def self.info
    with_identity('info')
  end
  
  def self.house_rules
    with_identity('house_rules')
  end
  
  def self.week_plan
    with_identity('week_plan')
  end
  
#  define_index do
#    indexes :title
#    indexes :body
#    indexes :language
#  end
  
  
end
