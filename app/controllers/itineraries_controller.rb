class ItinerariesController < ApplicationController
	before_action :set_itinerary, only: [:show, :edit, :update, :destroy]
	before_action :user_only, only: [:edit, :new, :update, :create, :destroy]
	def index
		
		if params[:event_id]
			@event = Event.find_by(id: params[:event_id])
			if @event == nil
				redirect_to events_path, :alert => "Event not found"
			else
				@itineraries = @event.compileTimeLine(@event.itineraries)
			end
		else
			redirect_to events_path, :alert => "Access Denied"
		end
		respond_to do |f|
	      f.html { render :index }
	      f.json { render json: @itineraries }
	    end
	end

	def show
		if params[:event_id]
			@event = Event.find_by(id: params[:event_id])
			@itinerary = @event.itineraries.find_by(id: params[:id])

			if @itinerary == nil
				redirect_to event_itineraries_path(@event), :alert => "Itinerary not found"
			end

		else
			@itinerary = Itinerary.find(params[:id])
			@event = @itinerary.event
		end
		respond_to do |f|
	      f.html { render :show }
	      f.json { render json: @itinerary }
	    end
	end

	def new
		@itinerary = Itinerary.new
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
		@itinerary = Itinerary.new(itinerary_params)
		if @itinerary.save
			redirect_to event_path(@itinerary.event), notice: "Itinerary successfully created"
		else
			@event = @itinerary.event
			render :new
		end
	end

	def edit
		@event = @itinerary.event
	end

	def update
		if @itinerary.update(itinerary_params)
			redirect_to event_path(@itinerary.event), notice: "Itinerary successfully updated"
		else
			@event = @itinerary.event
			render :edit
		end
	end

	def destroy
		Itinerary.delete(@itinerary)
		redirect_to event_path(@itinerary.event), notice: "itinerary deleted"
	end

	private
	def set_itinerary
		@itinerary = Itinerary.find(params[:id])
	end
	def itinerary_params
	      params.require(:itinerary).permit(
	    :event_id,
	    :note,
	    :location,
	    :meet_time,
	    :meet_day
	  	)
    end
end
