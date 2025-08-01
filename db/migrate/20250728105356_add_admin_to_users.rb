class AddAdminToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :admin, :boolean,default: false
  end
  def admin?
    self.admin == true
  end
end
