class UsersController < ApplicationController
  def new
    unless logged_in?
      @user = User.new
    else
      redirect_to tasks_path, notice: "ログインしているので新規登録はできません"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_path, notice: "登録できませんでした。同じメールアドレス使われている？"
    end
  end

  def show
    if User.ids.include?(params[:id].to_i)
      @user = User.find(params[:id])
        if @user.id == current_user.id
        else
          redirect_to tasks_path, notice: "ログインユーザーが違うのでプロフィールはみれません"
        end
    else
      redirect_to tasks_path, notice: "ログインユーザーが違うのでプロフィールはみれません"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:admin)
  end
end
