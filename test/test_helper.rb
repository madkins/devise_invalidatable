# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)

require 'rails'
require 'rails/test_help'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
