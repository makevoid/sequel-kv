# create table statements here (db initialization)

module SequelKV
module Init

  DB_NAME_DEFAULT = nil
  # # DB_NAME_DEFAULT = ENV["DB_NAME_DEFAULT"]
  # DB_NAME_DEFAULT = "yourname" (overrides the default name, 'main')

  def self.init!(log: false, db:)
    db_path = db_current_path

    # db_path = # if RACK_ENV == "development"
    #   db_current_path
    # # else
    # #   "#{db_current_path}/tmp/tmp.db"
    # #end

    @sequel_db = db || Sequel.connect("sqlite://#{db_path}")

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

    `#{mkdir}`
    # subdirs
    `#{mkdir}/dbs`

    # config file
    `echo "---" > #{mkdir}/config.yml`

    # ...
    # `#{mkdir}/antani/`
  end

  def self.create_tables!
    @sequel_db.create_table? :kv do |t|
      primary_key :id # auto increment numeric key
      # primary_key :key, String # alternative key (sha256, btc address, uuid, etc)

      String :key
      String :value
    end
  end

  # private

  def self.db_file_exists?
    File.exists? db_current_path
  end

  def self.db_current_path
    "#{APP_HOME}/dbs/#{DB_NAME_DEFAULT || "main"}.db" # other default names, default ...
  end

end
end
