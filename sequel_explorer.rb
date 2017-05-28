require 'sequel'

DB = Sequel.connect "sqlite://tmp.db"

DB

require 'roda'

class App < Roda
  plugin :render, engine: "haml"

  routes do |r|
    r.root do
      # {
      #   success: true
      # }

      view :index
    end
  end
end
