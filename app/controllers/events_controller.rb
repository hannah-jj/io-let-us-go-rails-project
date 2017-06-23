class EventsController < ApplicationController
	before_action :user_only, only: [:new, :edit, :update, :destroy]
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_action :user_autho, only: [:edit, :update, :destroy]
	def index
		@events = Event.all
	end

	def show
		#to display participants & stats of participants
		@event_user = Event_User.find_by(event: @event, participant: current_user)
		if @event_user.nil?
			@event_user = Event_User.new
		end
		@stats =Event_User.stats(@event, current_user)

		#to display comments from users
		@comments = @event.comments
		@comment = Comment.new

		#to display itineraries
		@itineraries = @event.itineraries

	end

	def new
		@event = Event.new
		@event.itineraries.build
		@event.itineraries.build
	end

	def create
		@event = Event.new(event_params)
		
		if @event.save
			redirect_to event_path(@event), notice: "Event successfully created"
		else
			render :new
		end
	end

	def update
		if @event.update(event_params)
			redirect_to event_path(@event), notice: "Event successfully updated"
		else
			render :edit, alert: "Event not updated"
		end
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def user_autho
		if @event.organizer != current_user
			redirect_to event_path(@event), alert: "Access denied"
		end
	end

	def event_params
	      params.require(:event).permit(
        :title,
        :note,
        :organizer_id,
        :location,
        :event_day,
        :itineraries_attributes => [
        	:id,
        	:note,
        	:location,
        	:meet_time,
        ]
      )
    end
end
