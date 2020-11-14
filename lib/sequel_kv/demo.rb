module SequelKV
class Demo

  def self.init!
    kv = KV.init!
    @db = kv.db

    @db[:kv].truncate

    puts "Empty value:"
    puts KV[:test].inspect

    KV[:test] = "foobar"

    puts "Value:"
    puts KV[:test].inspect
  end

end
end
