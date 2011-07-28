class AddInternalToNewsmail < ActiveRecord::Migration
  def self.up
    add_column :newsposts, :internal_letter, :boolean
  end

  def self.down
    remove_column :newsposts, :internal_letter
  end
end
