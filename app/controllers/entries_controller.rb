class EntriesController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def new
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:diary_id])
    @entry = @diary.entries.new
  end

  def create
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:diary_id])
    @entry = @diary.entries.new(entry_params)
    if @entry.save
      flash[:success] = "Ok, that's been saved!"
      redirect_to user_diary_entry_path @user, @diary, @entry
    else
      flash[:error] = 'There was a problem with the information that you submitted'
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:diary_id])
    @entry = @diary.entries.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:diary_id])
    @entry = @diary.entries.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:diary_id])
    @entry = @diary.entries.find(params[:id])
    if @entry.update(entry_params)
      flash[:success] = 'Entry updated'
      redirect_to user_diary_entry_path @user, @diary, @entry
    else
      flash[:error] = 'An error occurred whilst saving your changes'
      render 'edit'
    end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash[:success] = 'Entry deleted'
    redirect_to user_diary_path id: @diary
  end

  private

  def entry_params
    params.require(:entry).permit(:body)
  end

end
