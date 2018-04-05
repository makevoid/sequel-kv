require_relative "spec_helper"

describe "Sequel KV" do

  include SequelKV

  SKV = SequelKV
  KV  = SKV::KV

  # initial specs (checks that the lib is loaded into test suite)

  specify "SequelKV ruby module" do
    SKV.should be_a Module
    KV.should be_a Class
  end

  specify "spec init" do
    kv = KV.init!
    db = kv.db
    DB = db

    db.should be_a Sequel::SQLite::Database
  end

  # spec setup here:

  specify "spec environment init" do # before all
    DB.drop_table :kv
  end

  specify "db initialization" do
    KV.init!

    DB.tables.should include :kv
    columns = DB[:kv].columns
    columns.should include :id
    columns.should include :key
    columns.should include :value
  end

  specify "starts empty (db connection test)" do
    # empty table (DB[:kv])
    DB[:kv].first.should be_nil
  end

  specify "sets a value" do
    KV[:foo].should be_nil

    KV[:foo] = "bar"
  end

  specify "gets a value" do
    KV[:foo].should be_a String
    KV[:foo].should eq "bar"
  end

  specify "updates a value" do
    KV[:foo] = "baz"

    KV[:foo].should be_a String
    KV[:foo].should eq "baz"
  end

end
