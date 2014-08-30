class SessionController < ApplicationController
	def login
		if cookies[:auth_login].nil?

			if params['login'].nil? && params['password'].nil?
				
			else
				@user = User.where("lower(username) = ?", params['username'].mb_chars.downcase).first
				if @user.nil?
					flash[:notice] = I18n.t('alert_fail_login')
				else
					if @user.active == true
						if Digest::SHA1.hexdigest(params['password']) == @user.password
							if params[:remember]
						      cookies[:auth_login] = { :value => @user.username, :expires => Time.now + 3600*24*30}
						    else
						      cookies[:auth_login] = @user.username
						    end
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

	def logout
		if cookies[:auth_login].nil?
			redirect_to url_for(:controller => :session, :action => :login)
		else
			cookies.delete(:auth_login)
			redirect_to url_for(:controller => :session, :action => :login)
		end
	end

end
