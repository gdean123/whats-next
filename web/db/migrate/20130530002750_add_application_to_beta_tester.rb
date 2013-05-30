class AddApplicationToBetaTester < ActiveRecord::Migration
  def change
    add_column :beta_testers, :application, :string
  end
end
