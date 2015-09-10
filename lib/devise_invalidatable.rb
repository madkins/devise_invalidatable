unless defined?(Devise)
  require 'devise'
end
require 'devise_invalidatable'

Devise.add_module(:invalidatable,
                  model: 'devise_invalidatable/model')

module DeviseInvalidatable
end

class UserSession < ActiveRecord::Base
  def self.deactivate(session_id)
    where(session_id: session_id).delete_all
  end
end