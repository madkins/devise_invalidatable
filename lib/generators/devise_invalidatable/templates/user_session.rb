class UserSession
  include Mongoid::Document
  include Mongoid::Timestamps

  field :session_id, type: String
  field :ip, type: String
  field :user_agent, type: String

  belongs_to :<%= file_name %>

  index({ <%= file_name %>_id: 1 })
  index({ session_id: 1 }, { unique: true })

  def self.deactivate(session_id)
    where(session_id: session_id).delete_all
  end
end
