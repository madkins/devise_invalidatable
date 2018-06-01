# After authenticating, we’re removing any session activation that may already
# exist, and creating a new session# activation. We generate our own random id
# (in User#activate_session) and store it in the auth_id key. There is already
# a session_id key, but the session gets renewed (and the session id changes)
# after authentication in order to avoid session fixation attacks. So it’s
# easier to just use our own id.
Warden::Manager.after_set_user except: :fetch do |user, warden, _|
  UserSession.deactivate(warden.raw_session['auth_id'])
  warden.raw_session['auth_id'] = user.activate_session(ip: warden.request.ip,
                                                        user_agent: warden.request.user_agent)
end

# After fetching a user from the session, we check that the session is marked
# as active for that user. If it’s not we log the user out.
Warden::Manager.after_fetch do |user, warden, _|
  unless user.session_active?(warden.raw_session['auth_id'])
    warden.logout
    throw :warden, message: :unauthenticated if DeviseInvalidatable.throw_on_logout
  end
end

# When logging out, we deactivate the current session. This ensures that the
# session cookie can’t be reused afterwards.
Warden::Manager.before_logout do |_, warden, _|
  UserSession.deactivate(warden.raw_session['auth_id'])
end
