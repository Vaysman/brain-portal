class ApplicationController < ActionController::Base
	before_action :set_locale
	before_action :set_group, except:  :login
	def set_locale
	  I18n.locale = :ru || I18n.default_locale
	end

	def set_group
		@username = cookies[:auth_login]
		#raise @username.inspect
		if !@username.nil?
		  @user_info ||= User.find_by username: @username
		else
		  redirect_to url_for(:controller => :session, :action => :login)	
		end
	end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
