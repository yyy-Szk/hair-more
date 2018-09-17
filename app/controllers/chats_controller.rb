class ChatsController < ApplicationController
  before_action :check_index, only: [:index]
  before_action :check_show, only: [:show]
  before_action :check_new, only: [:new]

  def check_index
    if !logged_in_teacher? && !logged_in_user?
      redirect_to login_index_url, info: 'ログインしてください'
    end
  end

  def check_new
    if !logged_in_teacher?
      redirect_to topics_url, info: 'アクセスできません'
    end
  end

  def check_show
    room = Room.find_by(id: params[:id])
    if !logged_in_user? && !logged_in_teacher?
      redirect_to login_index_url, info: 'ログインしてください'

    elsif room.nil?
      redirect_to top_url, info: 'アクセスできません'

    elsif logged_in_user?
      if room.user_id != current_user.id
        redirect_to top_url, info: 'アクセスできません'
      end

    elsif logged_in_teacher?
      if room.teacher_id != current_teacher.id
        redirect_to top_url, info: 'アクセスできません'
      end

    end
  end



  def show
    room = Room.find(params[:id])
    @messages = Message.where(room_id: room.id)
    if logged_in_user?
      already_messages = Message.where(sender_id: room.teacher_id, teacher: "true")
      already_messages.update_all(read: "true")
    elsif logged_in_teacher?
      already_messages = Message.where(sender_id: room.user_id, teacher: "false")
      already_messages.update_all(read: "true")
    end
  end

  def index
    if logged_in_user?
      @rooms = Room.where(user_id: current_user.id)
    elsif logged_in_teacher?
      @rooms = Room.where(teacher_id: current_teacher.id)
    end
  end

  def new
    @room =Room.find_by(teacher_id: current_teacher.id, user_id: params[:user_id])
    if @room.nil?
      @room = Room.create(teacher_id: current_teacher.id, user_id: params[:user_id])
      redirect_to chat_url(id: @room.id)
    else
      redirect_to chat_url(id: @room.id)
    end
  end

end
