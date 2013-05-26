# coding: utf-8
# Author: Masayoshi Wada(@masawada)

require_relative '../app/app.rb'
require 'rack/test'
require 'json'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Kotonoha::Application
  end

  def test_404_error
    get '/may404'
    json = JSON.generate({is_success: false, error_code: 404, error_message: 'Resource not found.'})
    assert_equal json, last_response.body
  end
end
