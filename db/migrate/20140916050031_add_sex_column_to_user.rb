class AddSexColumnToUser < ActiveRecord::Migration
  def change
  	 add_column :users, :sex, :boolean
  end
end
