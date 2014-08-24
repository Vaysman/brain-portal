class UserController < ApplicationController
	def registration
		if (params['user'].nil?)
			@user = User.new
		else
			@user = User.new(user_params)
			if @user.save
				flash[:notice] = I18n.t('alert_registr')
				redirect_to url_for(:controller => :session, :action => :login)
			else
				render 'registration'
			end
		end

	end

	private
	  def user_params
	    params.require(:user).permit(:email, :password, :password_confirmation, :username)
	  end
end
