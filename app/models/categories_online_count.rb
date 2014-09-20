class CategoriesOnlineCount < ActiveRecord::Base
  def self.get_count(id)
  	@record = self.find_by(:category_id => id)
  	if (@record)
  	  @record.requests
  	else
  		0
  	end
  end
end
