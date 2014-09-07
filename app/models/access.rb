class Access < ActiveRecord::Base
	def self.is(alias_string, group_id)
		@alias_string = alias_string.split('.')
		@page_alias = @alias_string[0]+'.'+@alias_string[1]
		@page_id = Pages.get_id_by_alias(@page_alias)
		@action_alias = @alias_string[2]
		@action_id = PagesActions.get_id_by_alias(@action_alias)
		@action = GroupsToRoles.where(:group_id => group_id, :page_id => @page_id, :action_id => @action_id)
		if (@action.empty?)
			false
		else
			true
		end
	end
end
