class AddAttachmentImageToMeetionroom < ActiveRecord::Migration
  def self.up
    add_column :meetingrooms, :image_file_name, :string
    add_column :meetingrooms, :image_content_type, :string
    add_column :meetingrooms, :image_file_size, :integer
    add_column :meetingrooms, :image_updated_at, :datetime
  end

  def self.down
    remove_column :meetingrooms, :image_file_name
    remove_column :meetingrooms, :image_content_type
    remove_column :meetingrooms, :image_file_size
    remove_column :meetingrooms, :image_updated_at
  end
end
