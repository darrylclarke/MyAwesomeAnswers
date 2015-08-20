class ContactController < ApplicationController
	def index
		# render :index, layout: "application"
	end
	
	def create
		@name = params[:name]
		@email = params[:email]
		#render text:  "Thank you for contacketkj ius"
	end		
end
