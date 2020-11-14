require_relative '../lib/sequel_kv'
KV = SequelKV::KV

kv = KV.init!
@db = kv.db

puts "reset kv"
@db[:kv].truncate

puts "is :test empty? (nil is ok)"
puts KV[:test].inspect

puts "setting :test to 'foobar'"
KV[:test] = "foobar"

puts "getting :test"
puts KV[:test].inspect
