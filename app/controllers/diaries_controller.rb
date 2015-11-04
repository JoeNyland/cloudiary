class DiariesController < ApplicationController

  before_action :logged_in_user

  def new
    @diary = @current_user.diaries.new
  end

  def index
    @diaries = @current_user.diaries.all
  end

  def show
    @diary = Diary.find_by_id(params[:id])
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @diary = @user.diaries.new(diary_params)
    if @diary.save
      flash[:info] = 'Successfully created a diary'
      redirect_to user_url(id:@current_user)
    else
      flash[:error] = 'There was a problem with the information that you submitted'
      render :new
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title)
  end

end
