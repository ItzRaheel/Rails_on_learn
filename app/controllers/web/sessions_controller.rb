# app/controllers/web/sessions_controller.rb
class Web::SessionsController < Devise::SessionsController
  # Handles HTML/form-based authentication for Rails app
  
  protected
  
  def after_sign_in_path_for(resource)
    # Redirect after successful login
    root_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    # Redirect after logout
    root_path
  end
end