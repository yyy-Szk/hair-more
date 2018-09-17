class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], room_id: data['room_id'], sender_id: data['sender_id'], teacher: data['teacher'], read: data['read']
  end
end
