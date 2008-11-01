class AddResetAndAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_reset_code, :string, :limit => 40
    add_column :users, :is_admin, :default => false
  end

  def self.down
    remove_column :users, :password_reset_code
    remove_column :users, :is_admin
  end
end
