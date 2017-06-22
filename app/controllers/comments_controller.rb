class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]

	def index
		if params[:event_id]
			@event = Event.find_by(id: params[:event_id])
			if @event == nil
				redirect_to events_path, :alert => "Event not found"
			else
				@comments = @event.comments
			end
		else
			redirect_to events_path, :alert => "Access Denied"
		end
	end

	def show
		if params[:event_id]
			@event = Event.find_by(id: params[:event_id])
			@comment = @event.comments.find_by(id: params[:id])

			if @comment == nil
				redirect_to event_comments_path(@event), :alert => "Comment not found"
			end

		else
			@comment = Comment.find(params[:id])
			@event = @comment.event

		end
	end

	def new
		@comment = Comment.new
		if params[:event_id]
			@event = Event.find_by(id: params[:event_id])
			if @event == nil
				redirect_to events_path, :alert => "Event not found"
			end
		else
			redirect_to events_path, :alert => "Access Denied"
		end
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to event_path(@comment.event), notice: "Comment successfully created"
		else
			redirect_to event_path(@comment.event), alert: "comment didn't post correctly"
		end
	end

	def edit
		@event = @comment.event
	end

	def update
		if @comment.update(comment_params)
			redirect_to event_path(@comment.event), notice: "Comment successfully updated"
		else
			redirect_to event_path(@comment.event), alert: "Comment can't be blank"
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
