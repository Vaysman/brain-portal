class ApplicationController < ActionController::Base
	before_action :set_locale
	before_action :set_group
	def set_locale
	  I18n.locale = :ru || I18n.default_locale
	end

	def set_group
		@username = cookies[:auth_login]
		@user_info = User.find_by username: @username
	end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
