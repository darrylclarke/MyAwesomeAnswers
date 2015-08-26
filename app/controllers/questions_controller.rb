class QuestionsController < ApplicationController
	
	PER_PAGE = 10
	
	# The before action takes in a required first argument which references a method that will be 
	# executed before every action.  You can give it a second argument which is a hash.
	# Possible keys are :only and :except ==> if you want to restrict the method calls to specific actions.
	# before_action :find_question, except: [:index, :new, :create]
	before_action :find_question, only: [:show, :edit, :update, :destroy, :lock]
	
	# new is usually used in rails to display a form to create the record
	# (in this case a question record.)
	def new
		
		# This renders new.html.erb by default.
		
		# We instantiate an instance variable of the object we'd like to create in order
		# to use the form_for helper method in Rails to eality generate a form#
		# that submits to the create action
		#@question = Question.new( title: "Hello", body: "blue") #default is 'Hello'
		@question = Question.new( )
		
	end
	
	def create
		# prevent hackers from mass assigning other attributes.
		# params.require makes sure params has a key 'question' and fetches all the 
		# attribute from that hash.  The .permit only allows the parameters given to be
		# mass assigned.
		
		# This just creates a hash with a different objectId
		#question_params = params.require(:question).permit([:title, :body]) # can add new params
		#question_params => {title: "abc", body: "xyz" }
		
		# Rails expects a hash with a different object id than 'params'
		#q = Question.new params[:question_params]     # Mass assignment
		
		#q.title = params[:question][:title]
		#q.body  = params[:question][:body]

		@question = Question.new( question_params )

		if @question.save
			#render text: "Success"
			# Passing :notice :alert only works for redirect
			# It is the second parameter to "redirect_to"
			redirect_to question_path( @question ), notice: "Question Created!"
		else
			flash[:alert] = "See errors below."
			render :new
		end
			
	end
	
	# GET /questions/:id
	# This is used to show a page with quesetion info
	def show
		#@question = Question.find params[:id]  #:id is straight up in URL, no fancy stuff here.
		@answer = Answer.new #2015.08.25
	end
	
	# GET /questions
	# This is used to show a page with all of the questions in the database.
	def index
		# Better to make a better search method that takes a search term and order
		# Keep the controller as lean as Possible
		# Push stuff into the model.  (Or service objects, decorators --> learn later.)
		# Thin controllers, fat models. [[ for now ]]
		if params[:search]
			@questions = Question.search(params[:search]).order( params[:order])#.page(params[:page]).per(PER_PAGE)
		else
			@questions = Question.order(params[:order])#.page(params[:page]).per(PER_PAGE)
		end
	end
	
	def edit
		# @question = Question.find params[:id]
	end
	
	def update
		# This is using th strong parametes featur in Rails to allow only passsing title and body
		#question_params = params.require(:question).permit(:title, :body)
		
		#@question = Question.find params[:id]
		
		# If updating the question is successful
		if @question.update question_params
			# Redirect to question show page.
			redirect_to question_path(@question)
		else
			# Render the edit from so the user can see the errors.
			render :edit
		end
		#render text:  "Update!"
	end
	
	# DELETE /quesetions/:id  (i.e. /questions/123)
	# Delete a question from the database.
	def destroy
		@question.destroy
		redirect_to questions_path
	end
	
	def lock
		@question.locked = !@question.locked
		@question.save
		redirect_to question_path(@question)
	end
	
private

	def find_question
		@question = Question.find params[:id]
	end
	
	def question_params
		# params[:question] => {title: "Abc", body: "xyz"}
		# params.require ensures that the params hash has a key :question and
		# fetches all the attributes from that hash. the .permit only allows
		# the parameters given to be mass-assigned
		# question_params = params.require(:question).permit([:title, :body])
		# question_params =>  {title: "Abc", body: "xyz"}
		params.require(:question).permit(:title, :body, :locked, :category_id) #locked added 2015.08.26
 	end		
end
