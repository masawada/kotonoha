# coding: utf-8
# Author: Masayoshi Wada (@masawada)

current_path = File.dirname(__FILE__)
config = YAML.load_file(File.expand_path("#{current_path}/../config/database.yml"))

db = config[ENV['RACK_ENV'] || 'development']

db['database'] = File.expand_path("#{current_path}/#{db['database']}") if db['adapter'] == 'sqlite3'

ActiveRecord::Base.establish_connection(db)
