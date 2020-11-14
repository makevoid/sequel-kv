# create table statements here (db initialization)

module SequelKV
module Init

  DB_NAME_DEFAULT = ENV["DB_NAME_DEFAULT"] || "db"

  def self.init!(log: false, db:)
    db_path = db_current_path

    database = "sqlite://#{db_path}"

    if ENV["MYSQL"] = "1"
      mysql_cs = ENV["MYSQL_CS"]
      raise "MySQLConnStringNotSetError" if !mysql_cs || mysql_cs.empty?
      database = "mysql2://#{mysql_cs}"
    end

    @sequel_db = db || Sequel.connect(database)

    create_dirs!

    if db_file_exists?
      puts "Using DB file: #{db_current_path}" if log
    else
      puts "DB file not founc at: #{db_current_path}" if log
    end

    create_tables!

    self
  end

  def self.sequel_db
    @sequel_db
  end

  def self.create_dirs!
    mkdir = "mkdir -p #{APP_HOME}"

    puts `#{mkdir}`
  end

  def self.create_tables!
    @sequel_db.create_table? :kv do |t|
      primary_key :id # auto increment numeric key

      String :key
      String :value
    end
  end

  # private

  def self.db_file_exists?
    File.exists? db_current_path
  end

  def self.db_current_path
    "#{APP_HOME}/#{DB_NAME_DEFAULT}.db" # other default names, default ...
  end

end
end
