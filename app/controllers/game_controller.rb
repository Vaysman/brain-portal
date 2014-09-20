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
	  	
	end

	def message_new
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
