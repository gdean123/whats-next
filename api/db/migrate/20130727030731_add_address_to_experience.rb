class AddAddressToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :address, :string
  end
end
