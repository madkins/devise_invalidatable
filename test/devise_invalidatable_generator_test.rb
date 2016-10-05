require 'test_helper'
require 'generators/devise_invalidatable/devise_invalidatable_generator'

class DeviseInvalidatableGeneratorTest < Rails::Generators::TestCase
  tests DeviseInvalidatableGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))
  setup do
    prepare_destination

    model_destination = File.join(destination_root, 'app', 'models')

    # create model destination
    rm_rf(model_destination)
    mkdir_p(model_destination)

    # copy user model to tmp
    app_root = File.expand_path('dummy', File.dirname(__FILE__))
    user_model = File.join(app_root, 'app', 'models', 'user.rb')
    cp(user_model, model_destination)
  end

  test 'creates migration' do
    run_generator %w(User)
    assert_migration 'db/migrate/devise_create_user_sessions.rb'
  end

  test 'migration adds column user_id' do
    run_generator %w(User)
    assert_migration 'db/migrate/devise_create_user_sessions.rb' do |migration|
      assert_match(/column_name = :user_id/, migration)
    end
  end

  test 'migration adds column ip' do
    run_generator %w(User)
    assert_migration 'db/migrate/devise_create_user_sessions.rb' do |migration|
      assert_match(/string :ip/, migration)
    end
  end

  test 'migration adds column user_agent' do
    run_generator %w(User)
    assert_migration 'db/migrate/devise_create_user_sessions.rb' do |migration|
      assert_match(/string :user_agent/, migration)
    end
  end

  test 'does not create migration when using mongoid' do
    run_generator %w(User --mongoid)
    assert_no_migration 'db/migrate/devise_create_user_sessions.rb'
  end

  test 'creates user_session.rb when using mongoid' do
    run_generator %w(User --mongoid)
    assert_file 'app/models/user_session.rb'
  end

  test 'user_session.rb belongs to user' do
    run_generator %w(User --mongoid)
    assert_file 'app/models/user_session.rb' do |file|
      assert_match(/belongs_to :user/, file)
    end
  end

  test 'user_session.rb has ip field' do
    run_generator %w(User --mongoid)
    assert_file 'app/models/user_session.rb' do |file|
      assert_match(/field :ip/, file)
    end
  end

  test 'user_session.rb has user_agent field' do
    run_generator %w(User --mongoid)
    assert_file 'app/models/user_session.rb' do |file|
      assert_match(/field :user_agent/, file)
    end
  end

  test 'user_session.rb has index on user_id' do
    run_generator %w(User --mongoid)
    assert_file 'app/models/user_session.rb' do |file|
      assert_match(/index\(\{ user_id: 1 \}\)/, file)
    end
  end
end
