class UsersController < ApplicationController
  before_action :logged_in_only
  before_action :admins_only, only: :index


  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def logged_in_only
    redirect_to root_path, flash: {notice: 'You must log-in!'} unless user_signed_in?
  end

  def admins_only
    redirect_to root_path, flash: {notice: 'You must have permission!'} unless current_user.admin?
  end

end
