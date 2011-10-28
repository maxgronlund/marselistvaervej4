class Gallery < ActiveRecord::Base
  has_many :photos
  
  def self.with_identity(identity)
    where(:identity => identity).first
  end

  def self.marselistvaervej 
    with_identity('marselistvaervej ')
  end
  
  def self.history 
    with_identity('history ')
  end

end
