class GroupsToRoles < ActiveRecord::Base
	def self.change_roles(actions, group_id)
		GroupsToRoles.delete_all(:group_id => group_id)
		actions.each do |key, action|
			action.each do |keyt,act|
				@action = GroupsToRoles.new(:group_id => group_id, :page_id => key, :action_id => keyt)
				@action.save
			end
		end
	end
end
