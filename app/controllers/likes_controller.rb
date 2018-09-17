class LikesController < ApplicationController
  before_action :check, only: [:index]

  def check
    if logged_in_teacher?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_user?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end



  def index
    @likes = Like.where(user_id: current_user.id)
  end

  def create
    like = Like.new(
      user_id: current_user.id,
      name: current_user.name,
      topic_id: params[:topic_id])
    if like.save
      redirect_to topics_url
    else
      flash.now[:danger] = '失敗しました'
      render :index
    end
  end

  def destroy
    like = Like.find_by(topic_id: params[:topic_id], user_id: current_user.id)
    like.destroy
    redirect_to topics_url
  end

end
