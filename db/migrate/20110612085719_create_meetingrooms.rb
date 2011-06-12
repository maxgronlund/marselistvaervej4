class CreateMeetingrooms < ActiveRecord::Migration
  def self.up
    create_table :meetingrooms do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :meetingrooms
  end
end
