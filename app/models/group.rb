class Group < ActiveRecord::Base
	validates :title, presence: true 

	def make_new_default(is_default, new_title)
		if (is_default == 1)
			@old_default_group = Group.find_by is_default: true
			if (@old_default_group && @old_default_group.id != id)
				@old_default_group.update(:is_default => false)
			end
			self.update(:title => new_title, :is_default => true)
		else
			self.update(:title => new_title, :is_default => false)
		end
	end
end
