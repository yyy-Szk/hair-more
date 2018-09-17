class TopicsController < ApplicationController
  before_action :check, only: [:new, :edit]

  def check
    if logged_in_user?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_teacher?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end



  def new
    @topic  = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    if logged_in_user?
      @requet = Requet.find_by(user_id: current_user.id, topic_id: @topic.id)
    end
  end

  def create
    @topic = Topic.new(topic_params)     #current_teacherと関連づいた、topicテーブルを作成する（teacher_idにcurrent_teacherのIDが入っている）
    @topic.teacher_id = current_teacher.id
    @topic.name = current_teacher.name
    if @topic.save

      redirect_to topics_path, success: '投稿に成功しました'
    else
      @topic.save
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.likes.destroy_all
    @topic.requets.destroy_all
    @topic.destroy
    redirect_to topics_path, danger: '投稿を削除しました'
  end

  def update
    topic = Topic.find(params[:id])
    topic.update(topic_params)
    if topic.save
      redirect_to topic_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end

  end

  private

  def topic_params
    params.require(:topic).permit(:image, :description)
  end

end
