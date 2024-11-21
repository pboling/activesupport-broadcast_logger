# frozen_string_literal: true

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

platform :mri do
  # Debugging
  gem "byebug", ">= 11"
end

# Linting
gem "standard", "~> 1.42", ">= 1.42.1" # Ruby >= 3.0
gem "reek", "~> 6.3", ">= 6.3.0" # Ruby >= 3.0
