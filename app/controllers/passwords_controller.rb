class PasswordsController < Devise::PasswordsController
  layout false
  respond_to :html
  # after_action :redirect_to_index, :only => [:update]

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    redirect_to_index

    # if resource.errors.empty?
    #   resource.unlock_access! if unlockable?(resource)
    #   flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
    #   set_flash_message(:notice, flash_message) if is_flashing_format?
    #   sign_in(resource_name, resource)
    #   respond_with resource, location: after_resetting_password_path_for(resource)
    # else
    #   respond_with resource
    # end
  end

  private

  def redirect_to_index
    redirect_to new_user_session_path
  end
end
