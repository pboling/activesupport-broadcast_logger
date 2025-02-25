# This is a stub
# It will prevent vanilla ActiveSupport from loading its own broken logger tooling.
# Instead, we'll load the fixed replacement logging tooling from this library!
require_relative "../activesupport-broadcast_logger"

# In Rails 5: `ActiveSupport::Logger.broadcast console` was called from the ActiveRecord Railtie.
# We just need to stub that so it doesn't die, because this gem stack sets up logging separately.
ActiveSupport::Logger.class_eval do
  class << self
    # Needs to return a module...
    def broadcast(*_)
      Module.new
    end
  end
end
