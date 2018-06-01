unless defined?(Devise)
  require 'devise'
end
require 'devise_invalidatable'

Devise.add_module(:invalidatable,
                  model: 'devise_invalidatable/model')

module DeviseInvalidatable
  class << self
    attr_accessor :max_number_of_sessions
  end
  self.max_number_of_sessions = 10
end

if defined?(ActiveRecord)
  class UserSession < ActiveRecord::Base
    def self.deactivate(session_id)
      where(session_id: session_id).delete_all
    end
  end
end
