class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]

  protected
  def merge_projects
    projects = Project.where(soft_token: current_user.soft_token)
    projects.map do |project|
      project.user = current_user
      project.user_id = current_user.id
      project.save!
    end
  end

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
     devise_parameter_sanitizer.for(:sign_up) << :soft_token
  end

  # def sign_up_params
  #   params.require(:user).permit( :email, :password, :password_confirmation)
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    merge_projects
    super(resource)
  end

end