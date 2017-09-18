class AddImageToFacebooks < ActiveRecord::Migration
  def change
    add_column :facebooks, :image, :string
  end
end
