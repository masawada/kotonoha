# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require_relative '../app/app.rb'
require 'rack/test'
require 'json'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Kotonoha::Application
  end

  def test_root
    get '/'
    json = JSON.generate({message: 'hello, world', is_success: true})
    assert_equal json, last_response.body
  end

  def test_root_with_callback
    get '/', :callback => 'callback'
    json = JSON.generate({message: 'hello, world', is_success: true})
    assert_equal "callback(#{json})", last_response.body
  end
end
