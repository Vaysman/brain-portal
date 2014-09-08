class AddNewColumnsToUser < ActiveRecord::Migration
  def change
  	 remove_column :users, :city_id, :integer
  	 remove_column :users, :country_id, :integer
  	 add_column :users, :city, :string
  	 add_column :users, :country, :string
  end
end
