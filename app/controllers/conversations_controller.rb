class ConversationsController < ApplicationController
  def create
    if params[:user_id].present? && current_user
      @conversation = Conversation.get(current_user.id, params[:user_id])
      
      add_to_conversations unless conversated?
   
      respond_to do |format|
        format.js
      end
    elsif params[:pro_id].present? && current_pro
      @conversation = Conversation.get(current_pro.id, params[:pro_id])
      
      add_to_conversations unless conversated?
   
      respond_to do |format|
        format.js
      end
    elsif params[:pro_id].present? && current_user
      @conversation = Conversation.get(current_user.id, params[:pro_id])
      
      add_to_conversations unless conversated?
   
      respond_to do |format|
        format.js
      end
    elsif params[:user_id].present? && current_pro
      @conversation = Conversation.get(current_pro.id, params[:user_id])
      
      add_to_conversations unless conversated?
   
      respond_to do |format|
        format.js
      end
    end 
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end
 
  private
 
  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end
 
  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end