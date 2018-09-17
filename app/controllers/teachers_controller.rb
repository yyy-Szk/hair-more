class TeachersController < ApplicationController
  before_action :check_login, only: [:new]
  before_action :check_teacher?, only: [:edit]

  def check_login
    if logged_in_user? || logged_in_teacher?
      redirect_to topics_url, info: 'すでにログインしています'
    end
  end

  def check_teacher?
    if logged_in_user?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_teacher?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end



  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    same = Teacher.find_by(email: teacher_params[:email])
    if same.nil?
      if @teacher.save
        log_in_teacher @teacher
        redirect_to topics_url, success: '登録が完了しました'
      else
        flash.now[:danger] = @teacher.errors.full_messages
        render :new
      end
    else
      flash.now[:danger] = 'すでに登録済みのメールアドレスです'
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    @reviews = Review.where(teacher_id: params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(current_teacher.id)
    @teacher.update(teacher_params)
    @topic = Topic.find_by(teacher_id: current_teacher.id)
    if @topic
      @topic.update(name: teacher_params[:name])
    end
    if @teacher.save
      redirect_to teacher_path, success: 'プロフィールを更新しました'
    else
      flash.now[:danger] = @teacher.errors.full_messages
      render :edit
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :introduce, :password_confirmation, :image)
  end

  def log_in_teacher(teacher)
    session[:teacher_id] = teacher.id
  end

end
