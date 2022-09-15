class UsersController < ApplicationController
  before_action :logged_in_only
  before_action :admins_only, only: :index
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @user = User.all
  end

  def show
    @rentals = @user.rentals
  end

  def edit
  end

  def update
     if @user.update(user_params)
       redirect_to user_url(@user)
     else
       render 'edit'
     end
   end

   def destroy
     if @user.destroy
      redirect_to users_path, flash: {notice: 'User deleted!'}
     end
   end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end

  def logged_in_only
    redirect_to root_path, flash: {notice: 'You must log-in!'} unless user_signed_in?
  end

  def admins_only
    redirect_to root_path, flash: {notice: 'You must have permission!'} unless current_user.admin?
  end

end
