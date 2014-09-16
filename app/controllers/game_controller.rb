class GameController < ApplicationController
	def single
	  @categories = Category.all
	  @messages = Message.all
	end
	def message_new
		@message = Message.new
		@message.content = params[:message][:content]
		@message.user_id = @user_info.id
		@message.save!
		respond_to do |format|
            format.js 
        end
	end
  private
	  def msg_params
	    params.require(:message).permit(:content)
	  end
end
