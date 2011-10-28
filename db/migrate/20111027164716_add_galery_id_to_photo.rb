class AddGaleryIdToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :gallery_id, :integer
    
    Photo.all.each do |photo|
      photo.gallery_id = Gallery.first
      photo.save
    end
    
  end

  def self.down
    remove_column :photos, :gallery_id
  end
end
