# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS:
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update

# Used for head (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.2.2
# Test Matrix:
#   - Ruby 2.7
appraise "as-5-2" do
  gem "activesupport", "~> 5.2.8.1"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.7
appraise "as-6-0" do
  gem "activesupport", "~> 6.0.6.1"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.5
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
appraise "as-6-1" do
  gem "activesupport", "~> 6.1.7.10"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
appraise "as-7-0" do
  gem "activesupport", "~> 7.0.8.6"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 2.7
# Test Matrix:
#   - Ruby 2.7
#   - Ruby 3.0
#   - Ruby 3.1
#   - Ruby 3.2
appraise "as-7-1" do
  gem "activesupport", "~> 7.1.5"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 3.1
# Test Matrix:
#   - Ruby 3.1
#   - Ruby 3.2
#   - Ruby 3.3
appraise "as-7-2" do
  gem "activesupport", "~> 7.2.2"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Compat: Ruby >= 3.2
# Test Matrix:
#   - Ruby 3.2
#   - Ruby 3.3
#   - ruby-head
#   - truffleruby-head
#   - jruby-head
appraise "as-8-0" do
  gem "activesupport", "~> 8.0.0"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run security audit on latest Ruby version
appraise "audit" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/audit.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run coverage on latest Ruby version
appraise "coverage" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/coverage.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end

# Only run linter on latest Ruby version (but, in support of oldest supported Ruby version)
appraise "style" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/style.gemfile"
  remove_gem "appraisal" # only present because it must be in the gemfile because we target a git branch
end
