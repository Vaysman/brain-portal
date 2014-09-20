class CategoriesOnlineCount < ActiveRecord::Base
  def self.get_count(id)
  	@record = self.find_by(:category_id => id)
  	@record.requests
  end
end
