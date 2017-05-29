# to run this:

# time ruby tmp/naive_benchmark.rb


# -----

require 'benchmark'
require 'logger'

ENV["RACK_ENV"] = "test"
require_relative '../lib/sequel_kv'
KV = SequelKV::KV


# -------

# initialization

kv = KV.init!
# @db = kv.db
#
# @db[:kv].truncate


# -------

# benchmark config:

# database type:

# DATABASE_TYPE = :sqlite
# DATABASE_TYPE = :mysql
DATABASE_TYPE = :redis

if DATABASE_TYPE == :mysql
  puts "MYSQL"
  # override DB
  `mysql -u root -e 'CREATE DATABASE sequel_kv_benchmarks' IF NOT EXIST`
  database = "root@localhost/sequel_kv_benchmarks"
  db       = Sequel.connect "mysql2://#{database}"
  KV.class_variable_set "@@db", db
  # KV.class_variable_set "@@db", db
  KV.init! db: db
end

if DATABASE_TYPE == :redis # this doesn't actually test the gem at all but it's nice to perform a sql/relational db against a kv db
  puts "REDIS"
  Object.send :remove_const, :KV
  KV = Redis.new
end


def print(msg)
  puts msg
  puts "\n"*4
end

# TODO: use configurable size variables
a_few = 300
much  = 1000
lots  = 5_000


# TODO: benchmark inserting different key/vals
# TODO: benchmark with 1k - 10k - 100k - 1m keys already present

# ---

Benchmark.bm do |bm|

  if DATABASE_TYPE == :sqlite
    # init speed
    puts "initialization speed"
    bm.report do
      kv = KV.init!
      # kv ...
    end
  end

  # set-get 1000 new keys
  puts "SET-GET 1k key-value pairs"
  bm.report do
    KV[:test] = "foobar"
    KV[:test]
  end

  # set-get-log 250 new keys 400 updates (/dev/null or tmpfile)
  puts "SET-GET-log #{a_few} new kvs #{a_few} updates"
  LOGGER = Logger.new "/dev/null"
  # LOGGER = Logger.new "/tmfile"
  bm.report do
    100.times do |i|
      KV[:"test-#{i}"] = "foobar"
      msg = KV[:"test-#{i}"]
      LOGGER.info "msg: #{msg}"
    end

    100.times do |i|
      KV[:"test-#{i*2}"] = "foobar"
      msg = KV[:"test-#{i*2}"]
      LOGGER.info "msg: #{msg}"
    end
  end

  # set-get 300 existing keys
  puts "SET-GET 300 existing kvs"
  bm.report do |i|
    300.times do
      KV[:"test-#{i}"] = "foobar"
      KV[:"test-#{i}"]
    end
  end

  # get 5k keys
  puts "GET 5k existing kvs (same key)"
  bm.report do
    5_000.times do
      KV[:"test"]
    end
  end

end
