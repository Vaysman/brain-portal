class GameController < ApplicationController
	def single
	  if (!Access.is('game.single.index', @user_info.group_id))
			redirect_to root_path
	  end
	  @categories = Category.all
	  @messages = ChatMessage.all
	end

	def single_play
	  if (!Access.is('game.single.play', @user_info.group_id))
			redirect_to root_path
	  end
	  if (GameRequest.check_old_registration(@user_info.id, params[:id]) == true)
	  	flash[:alert] = I18n.t('old_register')
	  	redirect_to single_path
	  else	
	    GameRequest.register_user(@user_info.id, params[:id])
	  end
	end

	def message_new
		if (!Access.is('game.single.index', @user_info.group_id))
			redirect_to root_path
	   end
		@message = ChatMessage.new
		@message.content = params[:chat_message][:content]
		@message.user_id = @user_info.id
		@message.save
		respond_to do |format|
            format.js
            format.html
        end
	end
  private
	  def msg_params
	    params.require(:chat_message).permit(:content)
	  end
end
