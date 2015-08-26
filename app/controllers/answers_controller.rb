class AnswersController < ApplicationController
	
	def create
		@answer		= Answer.new answer_params				# make a new Answer
		
		#This adds a blank answer even if the operation fails due to validation.  Need to use <% @question.answers.reload.each do |a| %> in the view to get rid of the new answer.
		#@answer = @question.answers.new( answer_params ) #A1
		  
		@question	= Question.find params[:question_id]	# find associated question #A2-a
		@answer.question = @question						# link them up             #A2-b
		if @answer.save										# save it
			redirect_to question_path(@question),				# redirect back to question page in the 
				notice:  "Answer created!"						# normal way.
		else
			flash[:alert] = "Answer wasn't created."
			render "/questions/show"						# can't use :show b/c this conrller has no show
			              									# render doesn't reload the page
															# redirect is a whole new cycle, lose @answer
															# and @question, ==> lose errors attached to these
															# objects.
			# This will render show.html.erb within questions folder (in views).  We're choosing
			# to use "render" in here bec we want to disply the errors resulting frm unsuccessful save 
			# of @answer.  The errors are attached to the @answer ojject and can be acccessd in
			# @answer.errors
															
		end
		# render json: params
	end
	
	def destroy
		# render json: params
		@question = Question.find params[:question_id]
		@answer = Answer.find params[:id]
		@answer.destroy
		redirect_to question_path( @question ), notice:  "Answer deleted."
	end
	
private

	def answer_params
		params.require(:answer).permit(:body) # could put q-id here too.  Beter to find and do it yourself.
	end
	
end
