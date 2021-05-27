require 'pry'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require 'active_record'
require 'awesome_print'

require_relative '../lib/sample'
require_all 'lib/sample'
require_all 'app/models'

DB = ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "./db/mightyape_deals.db"
)

DB = ActiveRecord::Base.connection