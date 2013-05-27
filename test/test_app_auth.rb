# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require_relative '../app/utils/auth.rb'

class AppAuthTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Kotonoha::Application
  end

  def setup
    @auth = Kotonoha::Auth.new
  end

  def test_timestamp
    assert_equal true, @auth.send(:time?, Time.now.gmtime.iso8601(3).to_s)
  end
end
