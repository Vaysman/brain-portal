class PagesActions < ActiveRecord::Base

	def self.get_all
		array = Array.new
		array = {
			 1 => [
			    :id => '1',
			    :title => I18n.t('view'),
			    :alias => 'index'
			 ],
			 2 => [
			    :id => '2',
			    :title => I18n.t('create'),
			    :alias => 'create'
			 ],
			 3 => [
			    :id => '3',
			    :title => I18n.t('edit'),
			    :alias => 'edit'
			 ],
			 4 => [
			    :id => '4',
			    :title => I18n.t('delete'),
			    :alias => 'delete'
			 ],
			 5 => [
			    :id => '5',
			    :title => I18n.t('play'),
			    :alias => 'play'
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
