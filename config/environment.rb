require 'pry'
require 'rake'
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
 
# DB = ActiveRecord::Base.establish_connection(
#   ENV["./db/mightyape_deals.db"]
# )

# DB = ActiveRecord::Base.connection

# rake = Rake.application
# rake.init
# # you can import addition *.rake files
# # app.add_import 'some/other/file.rake'
# rake.load_rakefile
# rake['db:reset'].invoke()