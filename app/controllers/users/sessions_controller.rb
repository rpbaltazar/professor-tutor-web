class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :ensure_params_exist

  # POST /resource/sign_in
  def create
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:password])
      sign_in('user', user)
      render json: ::V1::User::Representer::Full.new(user), status: :ok
      return
    end
    invalid_login_attempt
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def ensure_params_exist
    return unless params[:email].blank? || params[:password].blank?
    render json: { errors: ['missing auth parameter'] }, status: :unprocessable_entity
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: { errors: ['wrong credentials'] }, status: :unauthorized
  end
end
