class AddColumnGroup < ActiveRecord::Migration
  def change
  	change_table :groups do |t|
      t.boolean :is_default	
    end
  end
end
