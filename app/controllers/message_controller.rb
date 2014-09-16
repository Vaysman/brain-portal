class MessageController < ApplicationController
	def new
		@message = Message.create!(params[:message])
	end
end
