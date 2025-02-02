# frozen_string_literal: true

source 'https://rubygems.org'

# make sure to use tls for github
git_source(:github) { |name| "https://github.com/#{name}.git" }

# Do not use fuzzy version matching (~>) with the Ruby version. It doesn't play
# nicely with RVM and we should be explicit since Ruby is such a fundamental
# part of a Rails project. The Ruby version is also locked in place by the
# Docker base image so it won't be updated with fuzzy matching.
ruby '2.5.8'
#ruby-gemset=conjur

gem 'base58'
gem 'command_class'
gem 'http', '~> 4.2.0'
gem 'iso8601'
gem 'jbuilder', '~> 2.7.0'
gem 'nokogiri', '>= 1.8.2'
gem 'puma', '~> 5.5.1'
gem 'rack', '~> 2.2.3'
gem 'rails', '~> 5.2'
gem 'rake'
# gem 'sprockets', '~> 3.7.0', '>= 3.7.2'

gem 'pg'
gem 'sequel'
gem 'sequel-pg_advisory_locking'
gem 'sequel-postgres-schemata', require: false
gem 'sequel-rails'

gem 'activesupport'
gem 'base32-crockford'
gem 'bcrypt', '~> 3.1.2'
gem 'gli', require: false
gem 'listen'
gem 'slosilo', '~> 2.2'

# Explicitly required as there are vulnerabilities in older versions
gem "ffi", ">= 1.9.24"
gem "loofah", ">= 2.2.3"

# Installing ruby_dep 1.4.0
# Gem::InstallError: ruby_dep requires Ruby version >= 2.2.5, ~> 2.2.
gem 'ruby_dep', '= 1.3.1'

gem 'conjur-api', '~> 5.pre'
gem 'conjur-policy-parser', path: 'gems/policy-parser'
gem 'conjur-rack', '~> 4'
gem 'conjur-rack-heartbeat'
gem 'rack-rewrite'

# Putting this here currently confuses debify, so instead load it in
# application.rb gem 'conjur_audit', path: 'engines/conjur_audit'

# This old version is required to work with CC
# See: https://github.com/codeclimate/test-reporter/issues/418
gem 'simplecov', '0.14.1', require: false

# gem 'autoprefixer-rails'
# gem 'bootstrap-sass', '~> 3.4.0'
gem 'dry-struct', '~> 0.4.0'
gem 'dry-types', '~> 0.12.2'
# gem 'font-awesome-sass', '~> 4.7.0'
gem 'net-ldap'
# gem 'sass-rails'

# for AWS rotator
gem 'aws-sdk-iam', require: false

group :production do
  gem 'rails_12factor'
end

# authn-k8s
gem 'event_emitter'
gem 'kubeclient'
gem 'websocket'

# authn-oidc, gcp, azure, jwt
gem 'jwt', '2.2.2' # version frozen due to authn-jwt requirements
# authn-oidc
gem 'openid_connect'

# Unpin version once this Github issue,
# https://github.com/palkan/anyway_config/issues/82
# is resolved
gem "anyway_config", "2.1.0"

group :development, :test do
  gem 'aruba'
  gem 'ci_reporter_rspec'
  gem 'conjur-cli', '~> 6.1'
  gem 'conjur-debify', require: false
  gem 'csr'
  gem 'cucumber'
  gem 'database_cleaner'
  gem 'debase'
  gem 'json_spec'
  gem 'net-ssh'
  gem 'parallel'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rails_layout'
  gem 'rake_shared_context'
  gem 'rspec'
  gem 'rspec-core', '~> 3.0'
  gem 'rspec-rails'
  gem 'ruby-debug-ide'
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
  gem 'table_print'
end

group :development do
  # NOTE: minor version of this needs to match codeclimate channel
  gem 'rubocop', '~> 0.58.0', require: false

  gem 'reek', require: false
  gem 'rubocop-checkstyle_formatter', require: false # for Jenkins
end

group :test do
  gem 'haikunator', '~> 1' # for generating random names in tests
end
