class AddIdentityToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :identity, :string
  end

  def self.down
    remove_column :galleries, :identity
  end
end
