# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/base'
require_relative './views/response.rb'

KOTONOHA_VERSION = 0.1
KOTONOHA_API_VERSION = 0.1

module Kotonoha
  class Application < Sinatra::Base
    configure do
      mime_type :json, 'application'
      #disable :raise_errors
      #disable :show_exceptions
    end

    before do
      configure_type :json
    end

    # Root
    get '/' do
      Kotonoha::Response.create({message: "hello, world"}, params[:callback])
    end
  end
end
