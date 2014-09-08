class Pages < ActiveRecord::Base
	def self.get_all
		array = Array.new
		array = {
			 1 => [
			    :id => '1',
			    :title => I18n.t('settings_groups'),
			    :alias => 'settings.groups'
			 ],
			 2 => [
			    :id => '2',
			    :title => I18n.t('setting_users'),
			    :alias => 'settings.users'
			 ],
			 
				}
		return array
	end

	def self.get_id_by_alias(alias_string)
		all = self.get_all
		all.each do |key, value|
			value.each do |attributes|
				if (attributes[:alias] == alias_string)
					return attributes[:id]
				end
			end
		end
		return 0
	end
end
