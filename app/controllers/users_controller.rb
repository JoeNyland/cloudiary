class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
    redirect_to root_url unless current_user == @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = 'Successfully signed you up!'
      redirect_to @user
    else
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
