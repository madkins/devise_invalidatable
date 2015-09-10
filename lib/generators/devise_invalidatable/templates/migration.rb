class DeviseCreateUserSessions < ActiveRecord::Migration
  @@table_name = :user_sessions
  @@column_name = :user_id

  def up
    create_table @@table_name do |t|
      t.integer @@column_name
      t.string :session_id
      t.timestamps
    end
    add_index(@@table_name, @@column_name)
    add_index(@@table_name, :session_id, unique: true)
  end

  def down
    drop_table(@@table_name)
  end
end
