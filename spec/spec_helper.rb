# frozen_string_literal: true

# Loading "active_support" normally here ensures this library will work,
#   even if loaded after the vanilla ActiveSupport.
# Unfortunately, it also results in 0% code coverage, because this gem gets loaded too early.
# require "active_support"

# External Deps
require "minitest"
require "test-unit"

# RSpec Configs
require "config/byebug"
require "config/rspec/rspec_block_is_expected"
require "config/rspec/rspec_core"
require "config/rspec/version_gem"
require "config/rails_backports"

# Last thing before loading this gem is to set up code coverage
begin
  # This does not require "simplecov", but
  require "kettle-soup-cover"
  #   this next line has a side effect of running `.simplecov`
  require "simplecov" if defined?(Kettle::Soup::Cover) && Kettle::Soup::Cover::DO_COV
rescue LoadError
  nil
end

# This library
require "activesupport-broadcast_logger"
