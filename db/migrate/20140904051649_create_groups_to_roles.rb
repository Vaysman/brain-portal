class CreateGroupsToRoles < ActiveRecord::Migration
  def change
    create_table :groups_to_roles do |t|
    	t.references :group, index: true
    	t.integer :page_id
    	t.integer :action_id
      t.timestamps
    end
  end
end
