class ConversationChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_from "conversations-#{current_user.id}"
      current_user.update_attributes(is_online: true)
    else 
      stream_from "conversations-#{current_pro.id}"
      current_pro.update_attributes(is_online: true)
    end
  end

  def unsubscribed
    stop_all_streams
    if current_user
      current_user.update_attributes(is_online: false)
    else
      current_pro.update_attributes(is_online: false)
    end
  end

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Message.create(message_params)
  end
end
