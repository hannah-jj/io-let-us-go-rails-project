class UsersController < ApplicationController
	before_action :user_only
	before_action :set_user, only: [:show, :edit, :update, :upcoming]
	before_action :user_autho, only: [:edit, :update, :upcoming]

	def update
		params[:user].delete(:password) if params[:user][:password].blank?
		if @user.update(user_params)
			redirect_to user_path(@user), notice: 'Profile was successfully updated'
		else
			render :edit
		end
	end

	def show
		respond_to do |f|
	      f.html { render :show }
	      f.json { render json: @user }
	    end
	end

	def upcoming
		@itineraries = @user.compileTimeLine(@user.upcoming_itineraries)
		respond_to do |f|
	      f.html { render :upcoming }
	      f.json { render json: @itineraries }
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
