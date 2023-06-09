class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :lastname)
  end

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: 'Signed up.' }
  end

  def register_failed
    render json: { message: 'Signed up failure.' }
  end

  def record_not_unique
    render json: { message: 'Account already exists.' }, status: :conflict
  end
end
