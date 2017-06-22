class EventUsersController < ApplicationController


	def create
		event = Event.find(params[:event_user][:event_id])
		if current_user
			@e = Event_User.new(e_params)
			@e.participant_id = current_user.id
			@e.save
			redirect_to event_path(@e.event), :notice => "participation added!"
		else
			redirect_to event_path(event), :alert => "please sign in to perform this action"
		end
	end

	def update
			@e = Event_User.find(params[:id])
			@e.update(e_params)
			redirect_to event_path(@e.event), :notice => "participation updated!"
	
	end

	def e_params
	      params.require(:event_user).permit(
        :event_id,
        :going,
        :participant_id,
      )
    end
end
