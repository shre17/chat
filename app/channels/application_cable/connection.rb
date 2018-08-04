module ApplicationCable
  # class Connection < ActionCable::Connection::Base
  #   identified_by :current_user
  #   identified_by :current_pro
 
  #   def connect
  #     self.current_user = find_verified_user
  #     self.current_pro = find_verified_pro
  #   end
 
  #   protected
 
  #   def find_verified_user
  #     if (current_user = env['warden'].user)
  #       current_user
  #     else
  #       reject_unauthorized_connection
  #     end
  #   end

  #   def find_verified_pro
  #     if (current_pro = env['warden'].pro)
  #       current_pro
  #     else
  #       reject_unauthorized_connection
  #     end
  #   end
  # end  
  class Connection < ActionCable::Connection::Base
    identified_by :current_pro, :current_user

    def connect
      find_verified
    end

    protected

    def find_verified
      setup_user if verified_user
      setup_pro if verified_pro

      reject_unauthorized_connection unless [current_pro, current_user].any?
    end

    def verified_user
      cookies.signed['user.expires_at'].present? &&
        cookies.signed['user.expires_at'] > Time.zone.now
    end

    def verified_pro
      cookies.signed['pro.expires_at'].present? &&
        cookies.signed['pro.expires_at'] > Time.zone.now
    end

    def setup_pro
      self.current_pro = Pro.find_by(id: cookies.signed['pro.id'])
      logger.add_tags 'ActionCable', "#{current_pro.model_name.name} #{current_pro.id}"
    end

    def setup_user
      self.current_user = User.find_by(id: cookies.signed['user.id'])
      logger.add_tags 'ActionCable', "#{current_user.model_name.name} #{current_user.id}"
    end
  end
end