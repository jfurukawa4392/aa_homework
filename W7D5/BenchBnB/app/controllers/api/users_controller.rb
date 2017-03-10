class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    p @user
    if @user.save
      login(@user)
      render 'api/users/show'
    else
      p @user
      render json: @user.errors.full_messages, status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
