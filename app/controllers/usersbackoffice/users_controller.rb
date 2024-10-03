class Usersbackoffice::UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  def sign_up
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User created successfully", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
