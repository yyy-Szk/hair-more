module ApplicationHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in_user?
    !current_user.nil?
  end

  def current_teacher
    @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
  end

  def logged_in_teacher?
    !current_teacher.nil?
  end

  def check_unlook_messages

    if logged_in_teacher?
      rooms = Room.where(teacher_id: current_teacher.id)
      rooms.each do |room|
        room.messages.each do |message|
          if message.teacher==false && message.read == false
            return true
          end
        end
      end
      return false

    elsif logged_in_user?
      rooms = Room.where(user_id: current_user.id)
      rooms.each do |room|
        room.messages.each do |message|
          if message.teacher==true && message.read == false
            return true
          end
        end
      end
      return false
    end
  end

end
