class SubscribeController < ApplicationController
	
	def index
	end
	
	def subscribe 
		@name = params[:name]
		@email = params[:email]
	end 
end
