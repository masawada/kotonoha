require 'bundler'
Bundler.require(:default, :console)

require 'active_record'
require 'securerandom'
require_relative '../db/connection.rb'
require_relative '../app/models/key.rb'
require_relative '../app/models/user.rb'

case ARGV[0]
when "gen"
  return if ARGV[1].nil?
  user = Kotonoha::Models::User.new
  user.name = ARGV[1]
  user.save

  key = Kotonoha::Models::Key.new
  key.user_id = user.id
  key.access = "#{user.id}-#{SecureRandom.uuid}"
  key.secret = "#{SecureRandom.base64(64)}"
  key.save
  puts "user generated\n"
#when "show"
#  users = Kotonoha::Models::User.where(:name => ARGV[1])
#  users.each do |u|
#    puts "id: #{u.id}\n"
#    puts "name: #{u.name}\n"
#    puts "access: #{u.access}\n"
#    puts "secret: #{u.secret}\n"
#    puts "---\n"
#  end
else
  puts "command is not defined\n"
end
