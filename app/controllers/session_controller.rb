class SessionController < ApplicationController
	def login
		if session[:user].nil?

			if params['login'].nil? && params['password'].nil?
				
			else
				@user = User.where("lower(username) = ?", params['username'].mb_chars.downcase).first
				if @user.nil?
					flash[:notice] = I18n.t('alert_fail_login')
				else
					if @user.active == true
						if Digest::SHA1.hexdigest(params['password']) == @user.password
							session[:user] = @user
							redirect_to url_for(:controller => :user, :action => :profile)
						else
							flash[:notice] = I18n.t('alert_fail_login')
						end
					else
						flash[:notice] = I18n.t('alert_fail_active')
					end
				end
			end
		else
			redirect_to url_for(:controller => :user, :action => :profile)
		end
	end
	

	def profile
	end

	def logout
		if session[:user].nil?
			redirect_to url_for(:controller => :session, :action => :login)
		else
			session[:user] = nil
			redirect_to url_for(:controller => :session, :action => :login)
		end
	end

end
