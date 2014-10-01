class Pages < ActiveRecord::Base
	def self.get_all
		array = Array.new
		array = {
			 1 => [
			    :id => '1',
			    :title => I18n.t('settings_groups'),
			    :alias => 'settings.groups',
			    :actions => [1, 2, 3, 4]
			 ],
			 2 => [
			    :id => '2',
			    :title => I18n.t('setting_users'),
			    :alias => 'settings.users',
			    :actions => [1, 2, 3, 4]
			 ],
			 3 => [
			    :id => '3',
			    :title => I18n.t('setting_categories'),
			    :alias => 'settings.categories',
			    :actions => [1, 2, 3, 4]
			 ],
			 4 => [
			    :id => '4',
			    :title => I18n.t('game_single_game'),
			    :alias => 'game.single',
			    :actions => [1, 5]
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
