class EventUsersController < ApplicationController
	before_action :user_only

	def create
		event = Event.find(params[:event_user][:event_id])
		
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

	private

	def e_params
	      params.require(:event_user).permit(
        :event_id,
        :going,
        :participant_id,
      )
    end
end
