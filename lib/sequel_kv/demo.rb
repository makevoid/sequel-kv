module SequelKV
class Demo

  def self.init!
    # DB = Seuel.connect "proto://.../db"
    kv = KV.init!
    @db = kv.db

    puts "Empty value:"
    puts KV[:test].inspect

    KV[:test] = "foobar"

    puts "Value:"
    puts KV[:test].inspect
  end

end
end
