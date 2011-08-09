class CreateCompanyThumbs < ActiveRecord::Migration
  def self.up
    create_table :company_thumbs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :company_thumbs
  end
end
