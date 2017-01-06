class Admin::UsersController < Admin::ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User has been created"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Error creating user"
      render :new
    end
  end


  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      flash[:success] = "User was updated successfully"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "Error updating the user"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end

end
