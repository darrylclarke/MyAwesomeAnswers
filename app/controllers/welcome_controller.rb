# Rails auto renders a tempalte with the views subfolder matching the controller 
# name. In this case the welcocme foleder. It will look for a file named 
#index with the appripriate foramt and templating language so we can write this


#setting the layout here changes default layout for all the actions in this controller
# layout "special"

class WelcomeController < ApplicationController
	def index
		#render text: "Hellow World"
		render :index, layout: "application"

		# alternative layout
		#render :index, layout: "special"		
	end
	
	def hello
		@name = params[:name] # This name comes from the /hello/:name part of the URL
		                      # Form data can come here too.
	end
end
