class Pages < ActiveRecord::Base
	def self.get_all
		array = Array.new
		array = {
			 1 => {
			    :id => '1',
			    :title => I18n.t('settings_groups'),
			    :alias => {1=>'1', 2=>'2', 3=>'3', 4=>'4'}
			 },
			 
				}
		return array
	end
end
