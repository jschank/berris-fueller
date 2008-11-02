class AddResetAndAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_reset_code, :string, :limit => 40
    add_column :users, :is_admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_admin
    remove_column :users, :password_reset_code
  end
end
