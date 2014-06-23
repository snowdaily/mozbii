class SessionsController < Devise::SessionsController
  layout false

  def password
    user = User.where(email: params.require(:user).permit(:email)[:email]).take
    user.send_reset_password_instructions
    # flash[:notice] = "Reset password instructions have been sent to #{user.email}."
    redirect_to new_user_session_path
  end
end
