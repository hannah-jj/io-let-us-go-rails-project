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

	def after_sign_in_path_for(resource)
    	request.env['omniauth.origin'] || home_path
	end

end
