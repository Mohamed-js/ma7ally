source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bcrypt', '~> 3.1.7'
gem 'shrine', '~> 3.3'
gem 'shrine-cloudinary', '~> 1.1'
gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'
gem 'simple_token_authentication', '~> 1.0'

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
