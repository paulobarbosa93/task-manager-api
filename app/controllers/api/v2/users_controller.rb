class Api::V2::UsersController < Api::V2::BaseController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  before_action :set_user, only: [:show]

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue StandardError
    head 404
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
