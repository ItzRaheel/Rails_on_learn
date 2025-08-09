# app/controllers/web/registrations_controller.rb
class Web::RegistrationsController < Devise::RegistrationsController
  # Handles HTML/form-based registration for Rails app
  
  protected
  
  def after_sign_up_path_for(resource)
    # Redirect after successful signup
    root_path
  end
end