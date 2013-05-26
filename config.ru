# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'bundler'
Bundler.require(:default, :server)

require './app/app.rb'
Kotonoha::Application.run! :port => 4423
