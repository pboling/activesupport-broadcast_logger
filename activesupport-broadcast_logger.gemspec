# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/activesupport/broadcast_logger/version.rb"
gem_version = Activesupport::BroadcastLogger::Version::VERSION
Activesupport::BroadcastLogger::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "activesupport-broadcast_logger"
  spec.version = gem_version
  # Not listing Rails Team here, as I don't want to imply that this is an official Rails anything.
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.summary = "Rails v8 ActiveSupport::BroadcastLogger, fixed & backported to Rails v5.2+ & Ruby 2.7+"
  spec.description = "Rails v8 ActiveSupport::BroadcastLogger, fixed & backported to Rails v5.2+ & Ruby 2.7+"
  spec.homepage = "https://github.com/pboling/#{spec.name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md"
  ]
  spec.bindir = "exe"
  spec.require_paths = ["lib"]

  # Extractions from Stdlib (Runtime)
  spec.add_dependency("logger", "~> 1.6", ">= 1.6.1")
  spec.add_dependency("mutex_m", "~> 0.1")
  spec.add_dependency("rdoc", "~> 6.8", ">= 6.8.1")
  spec.add_dependency("stringio", ">= 0.0.2")

  # Runtime Dependencies
  spec.add_dependency("activesupport", ">= 5.2")
  spec.add_dependency("activesupport-logger", "~> 2.0", ">= 2.0.2")
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.4")

  # Documentation
  spec.add_development_dependency("rdoc", "~> 6.8", ">= 6.8.1")
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.37")
  spec.add_development_dependency("yard-junk", "~> 0.0.10")

  # Coverage
  spec.add_development_dependency("kettle-soup-cover", "~> 1.0", ">= 1.0.4")

  # Unit tests
  spec.add_development_dependency("appraisal", "~> 2.5")
  spec.add_development_dependency("minitest", "~> 5.25", ">= 5.25.1")
  spec.add_development_dependency("rake", ">= 13")
  spec.add_development_dependency("rspec", "~> 3.13")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.6")
  spec.add_development_dependency("test-unit", "~> 3.6", ">= 3.6.2")

  # Linting
  spec.add_development_dependency("rubocop-lts", "~> 18.2", ">= 18.2.1") # Lint & Style Support for Ruby 2.7+
  spec.add_development_dependency("rubocop-packaging", "~> 0.5", ">= 0.5.2")
  spec.add_development_dependency("rubocop-rspec", "~> 3.0")
end
