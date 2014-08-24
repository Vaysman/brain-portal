class ChangeUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
	  t.boolean :active
	end
  end
end
