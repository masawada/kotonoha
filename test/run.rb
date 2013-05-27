# coding: utf-8
# Author: Masayoshi Wada (@masawada)

ENV['RACK_ENV'] = 'test'
RACK_ENV = 'test'

require_relative '../app/app.rb'
require 'test/unit'
require 'rack/test'
require 'json'

Test::Unit::AutoRunner.run(true, '.')
