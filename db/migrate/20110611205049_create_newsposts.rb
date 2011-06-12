class CreateNewsposts < ActiveRecord::Migration
  def self.up
    create_table :newsposts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :newsposts
  end
end
