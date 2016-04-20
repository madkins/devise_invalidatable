require 'rails/generators'

class DeviseInvalidatableGenerator < Rails::Generators::NamedBase
  if defined?(ActiveRecord)
    include Rails::Generators::Migration
  end

  desc 'Creates a migration to add the required attributes to NAME, and adds ' \
       'the necessary Devise directives to the model'

  def self.source_root
    @_devise_source_root ||= File.expand_path('../templates', __FILE__)
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    else
      '%.3d' % (current_migration_number(dirname) + 1)
    end
  end

  def generate
    if defined?(Mongoid)
      create_session_model
    elsif defined?(ActiveRecord)
      create_migration_file
    end

    inject_devise_directives_into_model
  end

  private

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/devise_create_user_sessions.rb'
  end

  def create_session_model
    model_path = File.join('app', 'models', 'user_session.rb')
    template('user_session.rb', model_path)
  end

  def inject_devise_directives_into_model
    model_path = File.join('app', 'models', "#{file_path}.rb")
    class_path = namespaced? ? class_name.to_s.split('::') : [class_name]
    indent_depth = class_path.size

    content = ['devise :invalidatable']
    content = content.map { |line| '  ' * indent_depth + line }.join("\n") << "\n"

    inject_into_class(model_path, class_path.last, content)
  end
end
