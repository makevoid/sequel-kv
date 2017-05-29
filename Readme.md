## SequelKV

#### Simple key-value store on top of the Sequel ruby query builder library

In dev mode it runs with a sqlite3 db

In prod you can use MySQL or other SQL lib (remember that postgres has a dedicated kv api and this gem is currently not taking advantage of it - you should use that if you're looking for performance - this is still a manual setting replace the DB constant yourself with remove const atm)


### Usage

This is the explanation of how to initialize and use the library with the default SQLite datastore:

```rb
# initialize the library
KV = SequelKV::KV
kv = KV.init!

# write a key-value pair
KV[:test] = "foobar"

# retrieve the value from the database
puts "Value:"
puts KV[:test].inspect
```


### Extra

Access to the Sequel DB instance manually

```
@db = kv.db # this is the sequel database
@db.tables  # returns [:kv]

@db[:kv] # this is the sequel table

@db[:kv].truncate # this will truncate the table - note: if you drop the table (ex: `mysql -e 'drop table kv'` in mysql) it will automatically re-created for you at init!
```


### Console

This will open an IRB session

    ./bin/console


### Console


This will open a standard Sequel CLI console


    ./bin/console_sequel



That's it for now!

---

Enjoy!

@makevoid
