require_relative "spec_helper"

describe "Sequel KV" do

  include SequelKV

  specify "spec init" do # before all
    DB[:kv_table].truncate
    SequelKV.init
  end

  specify "db initialization" do
    KV.init
    DB.tables.should include :kv_table
    columns = DB[:kv_table].columns
    columns.should include :id
    columns.should include :key
    columns.should include :value
  end

  specify "starts empty" do
    # empty table
    DB[:kv_table].first.should be_nil
    gets an empty value
  end

  xspecify "sets a value" do
    DB[:kv_table].first
  end

  xspecify "gets a value" do

  end

  xspecify "extra checks" do

  end
end
