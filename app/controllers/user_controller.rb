class UserController < ApplicationController
	def registration
		if (params['user'].nil?)
			@user = User.new
		else
			@user = User.new(user_params)
			if @user.save
				UserMailer.registration_email(@user).deliver
				redirect_to url_for(:controller => :session, :action => :login)
			else
				render 'registration'
			end
		end

	end

	def token
		if params['code'].nil?
			redirect_to url_for(:controller => :session, :action => :login)
		else
			@user = User.find_by(activation_token:(params['code']))
			if @user.nil?
				redirect_to url_for(:controller => :session, :action => :login)
			else
				@user.active = 1
				@user.activation_token = nil
				if @user.save
					flash[:notice] = I18n.t('alert_registr')
					redirect_to url_for(:controller => :session, :action => :login)
				else
					flash[:notice] = I18n.t('alert_registr_error')
					redirect_to url_for(:controller => :session, :action => :login)
				end
			end
		end	
	end



	def profile
		
	end


	private
	  def user_params
	    params.require(:user).permit(:email, :password, :password_confirmation, :username)
	  end
end
