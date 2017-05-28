
require_relative 'env'

module SequelKV
 # TODO: wrap everything in SequelKV module

 class DB::KV

   extend Init

   def self.init!
     Init.init!
   end

   def self.[](key)
     DB[:kv]
   end

   def self.[]=(key, value)
     id_next = DB[:kv].count
     DB[:kv].insert
   end

 end

end


# local test
if $0 == __FILE__
  # DB = Seuel.connect "proto://.../db"
  include SequelKV

  KV = DB::KV.init

  puts "Empty value:"
  puts KV[:test].inspect

  KV[:test] = "foobar"

  puts "Value:"
  puts KV[:test].inspect
end
