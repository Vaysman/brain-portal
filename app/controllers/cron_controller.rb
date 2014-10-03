class CronController < ApplicationController
	def delete_old_requests
	  @requests = GameRequest.all
	  @requests.each do |request|
	  	user = User.find_by(:id => request.user_id)
	  	last_move = user.check_online
	  	if (Time.now - last_move >= 60*15)
	  		request.destroy
	  	end
	  end
	  render :nothing => true, :status => 200, :content_type => 'text/html'
	end
end
