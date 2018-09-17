class SessionsController < ApplicationController
  before_action :check, only: [:teacher_new, :user_new, :index]

  def check
    if logged_in_user? || logged_in_teacher?
      redirect_to topics_url, info: 'すでにログインしています'
    end
  end



  def teacher_new
  end

  def user_new
  end

  def index
  end

  def destroy
    log_out
    redirect_to login_index_url, info: 'ログアウトしました'
  end

  def teacher_create
    teacher = Teacher.find_by(email: params[:session][:email])
    if teacher && teacher.authenticate(params[:session][:password])
      log_in_teacher teacher
      redirect_to topics_url, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :teacher_new
    end
  end

  def user_create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in_user user
      redirect_to topics_url, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :user_new
    end
  end

  private

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_in_teacher(teacher)
    session[:teacher_id] = teacher.id
  end

  def log_out
    session.delete(:user_id)
    session.delete(:teacher_id)
    @current_user = nil
    @current_teacher = nil
  end

end
