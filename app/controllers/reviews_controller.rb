class ReviewsController < ApplicationController
  before_action :check, only: [:new]

  def check
    if logged_in_teacher?
      redirect_to topics_url, info: 'アクセスできません'
    elsif !logged_in_user?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end


  
  def new
    @review = Review.new
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    @review = Review.new(review_params)
    @teacher = Teacher.find(review_params[:teacher_id])
    if @review.save
      redirect_to topics_path,success: '評価しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:star,:content,:teacher_id,:user_id)
  end
end
