class Category < ActiveRecord::Base
	has_many :question, dependent: :destroy
	def save_new_data(new_data)
	  if (new_data[:title])
	  	self.title = new_data[:title]
	  end
	  if (new_data[:description])
	  	self.description = new_data[:description]
	  end
	  if self.save
	  else
	  	self
	  end
	end
end
