class CommentsController < ApplicationController
	
	def create
		@comment = Comment.new comment_params	
		@answer  = Answer.find params[ :answer_id ]
		@comment.answer = @answer
		@comment.save
		
		answer_anchor = ActionController::Base.helpers.dom_id( @answer )
		redirect_to question_path( @answer.question ), 
					anchor: :answer_anchor,
		            notice: "Comment Created"
					
	end
	
	
private
	
	def comment_params
		params.require( :comment ).permit( :body )
	end
	
end
