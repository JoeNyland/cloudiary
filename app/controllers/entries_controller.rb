class EntriesController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def new
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.find_by_id(params[:diary_id])
    @entry = @diary.entries.new
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.find_by_id(params[:diary_id])
    @entry = @diary.entries.new(entry_params)
    if @entry.save
      flash[:info] = 'Successfully created a diary entry'
      redirect_to [@user,@diary,@entry]
    else
      flash[:error] = 'There was a problem with the information that you submitted'
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.find_by_id(params[:diary_id])
    @entry = @diary.entries.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.find_by_id(params[:diary_id])
    @entry = @diary.entries.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.find_by_id(params[:diary_id])
    @entry = @diary.entries.find_by_id(params[:id])
    if @entry.update(entry_params)
      flash[:success] = 'Entry updated'
      redirect_to [@user, @diary, @entry]
    else
      flash[:error] = 'An error occurred whilst saving your changes'
      render 'edit'
    end
  end

  def destroy
    Entry.find_by_id(params[:id]).destroy
    flash[:success] = 'Entry deleted'
    redirect_to user_diaries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:body)
  end

  # Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
