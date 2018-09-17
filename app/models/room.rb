class Room < ApplicationRecord

  belongs_to :user
  belongs_to :teacher

  has_many :messages

  # scope :teacher_messages, -> {messages.where("teacher=true")}
  # scope :room_find_teacher, -> (current_teacher){find_by("sender_id=#{current_teacher.id}")}
  # scope :current_teacher_messages, -> (current_teacher){where("sender_id=#{current_teacher.id}")}
  # scope :get_current_teacher_messages, -> (current_teacher){teacher_messages.current_teacher_messages(current_teacher)}
  # def not_read_teacher(current_teacher)
  #   return get_current_teacher_messages(current_teacher).last.read
  # end
  #
  # scope :user_messages, -> {messages.where("teacher=false")}
  # scope :current_user_messages, -> (current_user){where("sender_id=#{current_user.id}")}
  # scope :get_current_user_messages, -> (current_user){teacher_messages.current_user_messages(current_user)}
  # def not_read_user(current_user)
  #   return get_current_user_messages(current_user).last.read
  # end

end


# belongs_to :game
#
# scope :max_price, -> {maximum(:price)}
# scope :with_game, -> { joins(:game) }
# scope :get_max_price_item, -> (price){where("price=#{price}")}
# scope :get_platform_item, -> (platform){where("platform='#{platform}'",)}
#
# def self.getMaxPriceItem (platform)
#   return Gemeasp.with_game.get_max_price_item(Gemeasp.max_price).get_platform_item(platform)
# end
# end
