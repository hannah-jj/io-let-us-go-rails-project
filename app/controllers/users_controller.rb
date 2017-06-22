class UsersController < ApplicationController
	before_action :user_only
	before_action :set_user, only: [:show, :edit, :update]
	before_action :user_autho, only: [:edit, :update]

	def update
		if @user.update(user_params)
			redirect_to user_path(@user), notice: 'Profile was successfully updated'
		else
			render :edit
		end
	end

	private
	

	def set_user
		@user = User.find(params[:id])
	end

	def user_autho
		if current_user != User.find(params[:id])
			redirect_to user_path(@user), alert: 'Access Denied'
		end
	end

	def user_params
		params.require(:user).permit(
		:name,
		:email,
		:password,
		)
    end
end
