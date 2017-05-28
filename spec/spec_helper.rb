path = File.expand_path "../../", __FILE__

RSpec.configure do |config|
  # enable :should, more expressive, use expect for {}
	config.expect_with :rspec do |c|
	  c.syntax = [:expect, :should]
  end
end

require_relative "#{path}/lib/sequel_kv"
