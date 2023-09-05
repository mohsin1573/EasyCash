class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session  
  before_action :configure_permitted_parameters, if: :devise_controller?
    def after_sign_in_path_for(resource)
      if resource.role == 'admin'
        admin_accounts_path
      else
        super
      end
    end
      helper_method :current_user
    
     
      

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
      # Add other attributes as needed
    end
  end
  