class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    def logged_in?
    	!!current_user
  	end

  	def user_only
		if !logged_in?
			redirect_to home_path, alert: 'Access Denied'
		end
	end

end
