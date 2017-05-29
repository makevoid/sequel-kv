module SequelKV
  RACK_ENV = ENV["RACK_ENV"] || "development"
end

if defined? Bundler
  require 'bundler/setup'
  Bundler.require :default, SequelKV::RACK_ENV
else
  require 'sequel'
  if ENV["RACK_ENV"] == "test"
    require 'mysql2'
    require 'redis'
  end
end

module SequelKV

  PATH = File.expand_path "../", __FILE__

  # app's home (config, default db location) directory
  APP_HOME = File.expand_path "~/.sequel-kv/"

  require_relative 'sequel_kv/init'
end
