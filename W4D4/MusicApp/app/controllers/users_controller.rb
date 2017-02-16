class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to :users
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
