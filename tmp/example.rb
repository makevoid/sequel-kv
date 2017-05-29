require_relative '../lib/sequel_kv'
KV = SequelKV::KV

kv = KV.init!
@db = kv.db

@db[:kv].truncate

puts "Empty value:"
puts KV[:test].inspect

KV[:test] = "foobar"

puts "Value:"
puts KV[:test].inspect
