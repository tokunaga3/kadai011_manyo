class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :admin_user?

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザ情報を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザを抹殺しました！"
  end

  def index
    if admin_user?
      @users = User.all
    else
      redirect_to tasks_path, notice: "管理者以外はアクセスできないよ"
    end
  end

  def new
    @user = User.new
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
