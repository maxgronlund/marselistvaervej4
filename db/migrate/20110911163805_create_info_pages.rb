class CreateInfoPages < ActiveRecord::Migration
  def self.up
    create_table :info_pages do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :info_pages
  end
end
