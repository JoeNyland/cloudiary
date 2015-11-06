class DiariesController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def new
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.new
  end

  def index
    @user = User.find_by_id(params[:user_id])
    @diaries = @user.diaries.all
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @diary = Diary.find_by_id(params[:id])
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.new(diary_params)
    if @diary.save
      flash[:info] = 'Successfully created a diary'
      redirect_to [@user,@diary]
    else
      flash[:error] = 'There was a problem with the information that you submitted'
      render :new
    end
  end

  def edit
    @user = User.find_by_id(params[:user_id])
    @diary = Diary.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:user_id])
    @diary = Diary.find_by_id(params[:id])
    if @diary.update(diary_params)
      flash[:success] = 'Diary updated'
      redirect_to [@user, @diary]
    else
      flash[:error] = 'An error occurred whilst saving your changes'
      render 'edit'
    end
  end

  def destroy
    Diary.find_by_id(params[:id]).destroy
    flash[:success] = 'Diary deleted'
    redirect_to user_diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title)
  end

  # Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
