if defined? Bundler
  require 'bundler/setup'
  Bundler.require :default
end

module SequelKV
  PATH = File.expand_path "../", __FILE__
end
path = File.expand_path "../../", __FILE__


require 'sequel'

DB = Sequel.connect "sqlite://#{path}/tmp/tmp.db"

require_relative 'sequel_kv/init'
