class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :first_user
  
	



  protected
		def first_user
			@first_user = User.first
		end	
		def autenticacion_admin!
			redirect_to root_paht unless user_signed_in? && current_user.is_admin?
		end
private
  	def auth
  		unless user_signed_in?
			redirect_to new_user_session_path
		end

	end
end
