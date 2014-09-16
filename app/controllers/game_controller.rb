class GameController < ApplicationController
	def single
	  @categories = Category.all
	  @messages = Message.all
	end
	def messages_new

	end
end
