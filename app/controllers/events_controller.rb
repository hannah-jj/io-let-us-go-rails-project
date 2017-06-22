class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	def index
		@events = Event.all
	end

	def show

		@event_user = Event_User.find_by(event: @event, participant: current_user)
		
		if @event_user.nil?
			@event_user = Event_User.new
		end

		@stats =Event_User.stats(@event, current_user)

	end

	def new
		@event = Event.new
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
		@event = Event.update(event_params)
		redirect_to event_path(@event), notice: "Event successfully updated"
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
	      params.require(:event).permit(
        :title,
        :note,
        :organizer_id,
      )
    end
end
