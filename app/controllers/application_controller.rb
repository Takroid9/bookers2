class ApplicationController < ActionController::Base


 before_action :configure_permitted_parameters, if: :devise_controller?

 def set_current_user
  @current_user = User.find_by(id: session[:user.id])
 end

 def autheniticate_user
  if @current_user == nil
   redirect_to(new_user_session_path)
  end
 end
 


 def after_sign_in_path_for(resources)
  user_path(current_user.id)
 end

 def after_sign_out_path_for(resources)
  root_path
 end

 protected

 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
 end
end
