require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  test 'responds to user_sessions' do
    user = User.new
    assert_respond_to user, :user_sessions
  end

  test 'activate_session sets session_id' do
    user = User.new
    user.activate_session

    assert_not_nil user.user_sessions.first.session_id
  end

  test 'exclusive_session deletes all other sessions' do
    user = User.new(id: 1)
    user.activate_session # session #1
    session_id = user.activate_session # session #2

    assert_equal 2, user.user_sessions.count
    user.exclusive_session(session_id)
    assert_equal 1, user.user_sessions.count
  end

  test 'session_active? returns true when exists' do
    user = User.new(id: 1)
    session_id = user.activate_session

    assert_equal true, user.session_active?(session_id)
  end

  test 'session_active? returns false when does not exists' do
    user = User.new(id: 1)
    user.activate_session

    assert_equal false, user.session_active?('not-found')
  end

  test 'ensures number of sessions kept can be configured' do
    user = User.new(id: 1)
    DeviseInvalidatable.max_number_of_sessions = 20
    12.times { user.activate_session }

    assert_equal 12, user.user_sessions.count

    12.times { user.activate_session }
    assert_equal 20, user.user_sessions.count
  end

  test 'ensures only last 10 sessions kept by default' do
    user = User.new(id: 1)
    12.times { user.activate_session }

    assert_equal 10, user.user_sessions.count
  end
end
