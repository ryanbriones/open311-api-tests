require "bundler/setup"
Bundler.require(:default)

World(RSpec::Matchers)

require File.expand_path(File.dirname(__FILE__) + "/chicago_open311")

Dotenv.load
unless ENV["OPEN311_API_KEY"]
  $stderr.puts "Missing OPEN311_API_KEY Environment variable" 
  exit 1
end

unless ENV["OPEN311_BASE_URL"]
  $stderr.puts "Missing OPEN311_BASE_URL Environment variable" 
  exit 1
end
