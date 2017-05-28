if defined? Bundler
  require 'bundler/setup'
  Bundler.require :default
else
  require 'sequel'
end


module SequelKV
  RACK_ENV = ENV["RACK_ENV"]

  PATH = File.expand_path "../", __FILE__

  # app's home (config, default db location) directory
  APP_HOME = File.expand_path "~/.sequel-kv/"

  require_relative 'sequel_kv/init'
end
