Simple key-value store on top of the Sequel ruby query builder library

In dev mode it runs with a sqlite3 db

In prod you can use MySQL or other SQL lib (remember that postgres has a dedicated kv api and this gem is currently not taking advantage of it - you should use that if you're looking for performance)
