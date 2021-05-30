require 'pry'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require 'active_record'
require 'awesome_print'

require_relative '../lib/mighty_ape'
require_all 'lib/mighty_ape'
require_all 'app/models'

DB = ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "./db/mightyape_deals.db"
)

DB = ActiveRecord::Base.connection