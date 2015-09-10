require 'devise_invalidatable/hooks/invalidatable'

module Devise
  module Models
    module Invalidatable
      extend ActiveSupport::Concern

      included do
        has_many :user_sessions,
                 class_name: 'UserSession',
                 foreign_key: :user_id,
                 dependent: :destroy
      end

      def activate_session
        new_session = user_sessions.new
        new_session.session_id = SecureRandom.hex(127)
        new_session.save
        purge_old_sessions
        new_session.session_id
      end

      def exclusive_session(session_id)
        user_sessions.where('session_id != ?', session_id).delete_all
      end

      def session_active?(session_id)
        user_sessions.where(session_id: session_id).exists?
      end

      def purge_old_sessions
        user_sessions.order('created_at desc').offset(10).destroy_all
      end

    end
  end
end
