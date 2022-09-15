class UsersController < ApplicationController
  before_action :admins_only, only: [:index, :new]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @user = User.all
  end

  def show
    @rentals = @user.rentals
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to users_path, flash: {notice: 'User created!'}
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
     if @user.update(user_params)
       redirect_to user_url(@user)
     else
       render :edit, status: :unprocessable_entity
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
    params.require(:user).permit(:name, :email, :admin, :password)
  end

  def admins_only
    redirect_to root_path, flash: {notice: 'You must have permission!'} unless current_user.admin?
  end

end
