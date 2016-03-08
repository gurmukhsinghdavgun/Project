class Recruiters::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    profiles_path
  end
  
end
