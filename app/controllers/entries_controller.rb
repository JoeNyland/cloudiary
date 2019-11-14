class EntriesController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def index
    @user = User.find(params[:user_id])
    @entries = @user.entries.order :created_at
  end

  def new
    @user = User.find(params[:user_id])
    @entry = @user.entries.new
  end

  def create
    @user = User.find(params[:user_id])
    @entry = @user.entries.new(entry_params)
    if @entry.save
      flash[:success] = "Ok, that's been saved!"
      redirect_to user_entry_path @user, @entry
    else
      flash[:error] = 'There was a problem with the information that you submitted'
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
    if @entry.update(entry_params)
      flash[:success] = 'Entry updated'
      redirect_to user_entry_path @user, @entry
    else
      flash[:error] = 'An error occurred whilst saving your changes'
      render 'edit'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @user = @entry.user
    @entry.destroy
    flash[:success] = 'Entry deleted'
    redirect_to user_entries_path(@user)
  end

  private

  def entry_params
    params.require(:entry).permit(:body)
  end

end
