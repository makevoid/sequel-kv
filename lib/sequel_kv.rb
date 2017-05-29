require_relative 'env'

module SequelKV
class KV # Key Value

  LOG = false

  def self.init!(db: nil)
    instance = Init.init! log: LOG, db: db
    @@db = instance.sequel_db
    self
  end

  def self.db
    @@db
  end

  def self.[](key)
    puts "GET #{key.inspect}" if LOG
    key = key.to_s
    record = db[:kv].where(key: key).first
    record[:value] if record
  end

  def self.[]=(key, value)
    puts "SET #{key.inspect}" if LOG
    key = key.to_s
    record = db[:kv].where key: key
    if record.first
      update record: record, value: value
    else
      insert key: key, value: value
    end
  end

  private

  def self.insert(key:, value:)
    puts "Key doesn't exists: insert" if LOG
    id_next = db[:kv].count
    db[:kv].insert key: key, value: value
  end

  def self.update(record:, value:)
    puts "Key exists: update" if LOG
    record.update value: value
  end

end
end


# local test
if $0 == __FILE__
  require_relative 'sequel_kv/demo'
  SequelKV::Demo.init!
end
