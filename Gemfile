source 'http://rubygems.org'
source 'http://gems.github.com'

gem 'rails', '>=3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
gem 'haml'
#gem 'eve'
gem 'jquery-rails'
gem 'hashtrain-acts_as_random_id', :require => 'acts_as_random_id'
gem 'rails3-jquery-autocomplete'
gem "compass", ">= 0.10.6"
gem "rails3_acts_as_paranoid"
gem 'newrelic_rpm'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  # gem 'webrat'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
group :development do
  #gem 'ruby-debug19'
  gem 'annotate'
  gem 'haml-rails'
end
group :production do
  #gem 'ruby-mysql'
  gem 'pg'
  gem 'thin'
end