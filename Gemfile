source "https://rubygems.org"

gem "sqlite3"
gem "sequel"

group :development do
  gem "rake"
end


# note: install this gemfile with `bundle --without test` (mysql2 and redis as extra dependencies - also note that sqlite3 default dependency can be removed if used with mysql/postrgres or another db)

group :test do
  gem "mysql2"
  gem "rspec-core"
  gem "rspec-mocks"
  gem "rspec-expectations"

  gem "redis"
end
