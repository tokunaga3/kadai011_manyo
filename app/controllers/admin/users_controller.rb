class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
      redirect_to edit_admin_user_path, notice:"管理者がいなくなるのでできません"
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"ユーザを抹殺しました！"
    else
      redirect_to admin_users_path, notice:"管理者がいなくなるのでできません"
    end
  end

  def index
    if admin_user?
      @users = User.select(:name, :email, :admin, :id, :admin, :created_at)
    else
      redirect_to tasks_path, notice: "管理者以外はアクセスできないよ"
    end
  end

  def new
    @user = User.new
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:admin)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
