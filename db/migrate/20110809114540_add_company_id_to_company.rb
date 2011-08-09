class AddCompanyIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :company_thumbs, :company_id, :integer
  end

  def self.down
    remove_column :company_thumbs, :company_id
  end
end
