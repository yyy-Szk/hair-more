class UsersController < ApplicationController
  before_action :check_login, only: [:new]
  before_action :check_user?, only: [:edit]

  def check_login
    if logged_in_user? || logged_in_teacher?
      redirect_to topics_url, info: 'すでにログインしています'
    end
  end

  def check_user?
    if logged_in_teacher?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_user?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end



  def index
      redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    same = User.find_by(email: user_params[:email])
    if same.nil?
      if @user.save
        log_in_user @user
        redirect_to topics_url, success: '登録が完了しました'
      else
        flash.now[:danger] = @user.errors.full_messages
        render :new
      end
    else
      flash.now[:danger] = 'すでに登録済みのメールアドレスです'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    user = User.find(current_user.id)
    user.update(user_params)
    if user.save
      redirect_to user_path, success: 'プロフィールを更新しました'
    else
      flash.now[:danger] = @user.errors.full_messages
      render :edit
    end

  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :introduce, :password, :password_confirmation, :image)
  end

  def log_in_user(user)
    session[:user_id] = user.id
  end

end
