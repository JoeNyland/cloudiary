class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = @current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Successfully signed you up! We've logged you in so you can get started!"
      redirect_to @user
    else
      flash[:danger] = 'There was a problem with the information that you submitted.'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
