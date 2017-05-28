# create table statements here (db initialization)

module SequelKV
class Init

  def self.init!
    # `touch #{PATH}/tmp/tmp.db`

    DB.create_table? :kv do |t|
      # primary_key :key, String
      primary_key :id

      String :key
      String :value
    end
  end

end
end
