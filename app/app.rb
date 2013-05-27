# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/base'
require_relative './views/response.rb'
require_relative './utils/errors.rb'

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
      content_type :json
    end

    [ ERR::BadRequest,
      ERR::AuthorizationFailed,
      ERR::RequestForbidden,
      ERR::UserNotFound,
      ERR::LeafNotFound,
      ERR::InternalServerError,
    ].each do |err|
      error err do
        status err.code
        Kotonoha::Response.error(err.code, err.message, params[:callback])
      end
    end

    not_found do
      err = ERR::NotFound
      Response.error(err.code, err.message, params[:callback])
    end

    error 500 do
      err = ERR::InternalServerError
      Response.error(err.code, err.message, params[:callback])
    end

    # Auth
    [ '/statuses/update',
      %r{$/statuses/destroy/[1-9][0-9]*^}
    ].each do |route|
      before route do
        @auth = Auth.new
        @auth.authorize?(params)
      end
    end

    # Root
    get '/' do
      Response.create({message: "hello, world"}, params[:callback])
    end
  end
end
