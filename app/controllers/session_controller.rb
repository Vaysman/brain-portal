class SessionController < ApplicationController
	def login
		if params['login'].nil? && params['password'].nil?
			
		else
			@user = User.where("lower(username) = ?", params['username'].downcase).first
			if @user.nil?
				flash[:notice] = I18n.t('alert_fail_login')
			else
				if Base64.encode64(params['password']) == @user.password
					session[:user] = @user
					redirect_to url_for(:controller => :user, :action => :profile)
				else
					flash[:notice] = I18n.t('alert_fail_login')
				end
			end
		end
	end
	def index
	end
end
