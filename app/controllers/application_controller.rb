class ApplicationController < ActionController::Base
	
	before_action :set_locale
	before_action :set_group, except:  [:login, :registration, :token]
	before_action :check_online, except: [:login, :registration, :token, :logout, :delete_old_requests]
	def set_locale
	  I18n.locale = :ru || I18n.default_locale
	end

	def set_group
		@username = cookies[:auth_login]
		if !@username.nil?
		  @user_info ||= User.find_by username: @username
		else
		  redirect_to url_for(:controller => :session, :action => :login)	
		end
	end

	def check_online
	  return if self.controller_name == 'Cron'
	  @username = cookies[:auth_login]
	  if !@username.nil?
	    @user_info ||= User.find_by username: @username
	    @check = CheckOnline.find_by(:user_id => @user_info.id)
	    if (!@check.nil?)
	      @check.destroy
	    end
	    @check_online = CheckOnline.new
	    @check_online.user_id = @user_info.id
	    @check_online.time = Time.zone.now
	    @check_online.save
	  end 	
	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
