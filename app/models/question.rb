class Question < ActiveRecord::Base
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	def self.get_category(id)
		@category = Category.find_by id: id
	end
end
