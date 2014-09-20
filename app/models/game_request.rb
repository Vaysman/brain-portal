class GameRequest < ActiveRecord::Base
	def self.check_old_registration(user_id, category_id)
	  @old_register = self.find_by(:user_id => user_id, :category_id => category_id)
	  if (@old_register.nil?)
	 	 false
	  else
	  	 true
	  end
	end

	def self.register_user(user_id, category_id)
	  @record = self.new
	  @record.user_id = user_id
	  @record.category_id = category_id
	  @record.save
	end
end
