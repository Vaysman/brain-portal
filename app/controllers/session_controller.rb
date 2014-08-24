class SessionController < ApplicationController
	def login
		if params['login'].nil? && params['password'].nil?
			
		else
			@user = User.where("lower(username) = ?", params['username'].mb_chars.downcase).first
			if @user.nil?
				flash[:notice] = I18n.t('alert_fail_login')
			else
				if Digest::SHA1.hexdigest(params['password']) == @user.password
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
