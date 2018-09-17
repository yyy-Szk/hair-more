class RequetsController < ApplicationController
  before_action :check_index, only: [:index]
  before_action :check_new, only: [:new]

  def check_new
    if logged_in_teacher?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_user?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end

  def check_index
    if logged_in_user?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_teacher?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end
  


  def new
    @requet = Requet.new
    @topic = Topic.find(params[:id])
  end

  def index
    @topic = Topic.find_by(teacher_id: current_teacher.id)
    @requets = Requet.where(topic_id: current_teacher.topics)
  end

  def create
    @requet = Requet.new(requet_params)
    @topic = Topic.find(params[:topic_id])
    @requet.update(user_id: current_user.id, topic_id: params[:topic_id] , name: current_user.name)
    if @requet.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def requet_params
    params.require(:requet).permit(:description)
  end
end
