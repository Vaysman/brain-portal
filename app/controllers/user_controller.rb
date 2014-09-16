class UserController < ApplicationController
	def registration
		if (params['user'].nil?)
			@user = User.new
		else
			@user = User.new(user_params)
			@def_group = Group.find_by is_default: true
			@user.group_id = @def_group.id
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
		if @user_info.nil?
		  redirect_to url_for(:controller => :session, :action => :login)
		end
		@user = User.find_by(id: @user_info.id)
		@user_last_move = @user.check_online
		if (Time.now - @user_last_move < 15*60)
			@status = true
		else @status = false
		end

	end
	def edit_profile
		if @user_info.nil?
		  redirect_to url_for(:controller => :session, :action => :login)
		end
		@user = User.find_by(id: @user_info.id)
		if (params[:user])
		end	
	end


	private
	  def user_params
	    params.require(:user).permit(:email, :password, :password_confirmation, :username)
	  end
end
