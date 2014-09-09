class Question < ActiveRecord::Base
	belongs_to :category
	has_attached_file :image
	def self.get_category(id)
		@category = Category.find_by id: id
	end
end
