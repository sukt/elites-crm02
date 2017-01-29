class AddPictureToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :picture, :text
  end
end
