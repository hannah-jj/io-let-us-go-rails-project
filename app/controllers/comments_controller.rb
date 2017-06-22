class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to event_path(@comment.event), notice: "Comment successfully created"
		else
			redirect_to event_path(@comment.event), alert: "comment didn't post correctly"
		end
	end

	def destroy
		Comment.delete(@comment)
		redirect_to event_path(@comment.event), notice: "comment deleted"
	end

	private
	def set_comment
		@comment = Comment.find(params[:id])
	end
	def comment_params
	      params.require(:comment).permit(
	    :event_id,
	    :note,
	    :user_id,
	  	)
    end
end
