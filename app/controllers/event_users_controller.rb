class EventUsersController < ApplicationController
	before_action :user_only

	def create

		@e = Event_User.new(e_params)
		@e.participant_id = current_user.id
		@e.save
		redirect_to event_path(@e.event), :notice => "participation added!"
	end

	def update
			@e = Event_User.find(params[:id])
			@e.update(e_params)
			redirect_to event_path(@e.event), :notice => "participation updated!"
	end

	def ajax_create
		data = params["event_users"]
		@e = current_user.event_users.find_by(event_id: data["event_id"])
		
		if @e #had an instance previously
			@e.update(going: data["going"])
		else
			@e = Event_User.new()
			@e.participant_id = current_user.id
			@e.event_id = data["event_id"]
			@e.going = data["going"]
			@e.save
		end

		render json: @e.event
	end

	private

	def e_params
	      params.require(:event_user).permit(
        :event_id,
        :going,
        :participant_id,
      )
    end
end
