class HomeController < ApplicationController
  def index
    session[:conversations] ||= []
 
    @users = User.all.where.not(id: current_user)
    @user_conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
    @pros = Pro.all.where.not(id: current_pro)
    @pro_conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])                                 
  end
end
