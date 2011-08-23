class AddColorToMeetingrooms < ActiveRecord::Migration
  def self.up
    add_column :meetingrooms, :color, :string
  end

  def self.down
    remove_column :meetingrooms, :color
  end
end
