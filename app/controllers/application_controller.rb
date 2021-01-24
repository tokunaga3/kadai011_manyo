class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # include TasksHelper

  def authenticate_user
    # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if current_user == nil
      flash[:notice] = t('ログインが必要です')
      redirect_to new_session_path
    end
  end
  def admin_user?
    if current_user.present?
      current_user.admin?
    else
      redirect_to new_session_path, notice: "セッションが切れたのでログインし直してください"
    end
  end
end
