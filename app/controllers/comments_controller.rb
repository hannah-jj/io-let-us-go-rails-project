class CommentsController < ApplicationController
	before_action :set_comment, only: [:edit, :update, :destroy]
	before_action :user_only, only: [:new, :edit, :update, :destroy]
	before_action :user_autho, only: [:edit, :update, :destroy, :delete]

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
			@event = @comment.event
			render :new
		end
	end

	def edit
		@event = @comment.event
	end

	def update
		if @comment.update(comment_params)
			redirect_to event_path(@comment.event), notice: "Comment successfully updated"
		else
			@event = @comment.event
			render :edit
		end
	end

	def destroy
		Comment.delete(@comment)
		redirect_to event_path(@comment.event), notice: "comment deleted"
	end

	private
	def user_autho
		
		if @comment.user != current_user
			redirect_to comment_path(@comment), alert: "Access denied"
		end
	end

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
