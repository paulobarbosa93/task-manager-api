class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  respond_to :json

  def show
    respond_with @user
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
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
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
