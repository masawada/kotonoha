# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/base'
require_relative './views/response.rb'
require_relative './utils/errors.rb'
require_relative './utils/utils.rb'
require_relative './utils/auth.rb'
require_relative './models/leaf.rb'
require_relative './models/key.rb'
require_relative './models/user.rb'
require_relative './controllers/statuses_controller.rb'

KOTONOHA_VERSION = 0.1
KOTONOHA_API_VERSION = 0.1

module Kotonoha
  class Application < Sinatra::Base
    configure do
      mime_type :json, 'application'
      disable :raise_errors
      disable :show_exceptions
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
    [ ['/statuses/update', ["text","access","timestamp"]],
      [%r{^/statuses/destroy/([1-9][0-9]*)$}, ["access", "timestamp"]]
    ].each do |route|
      before route[0] do
        @auth = Auth.new
        @auth.authorize?(params, route[1], env)
      end
    end

    # Root
    get '/' do
      Response.create({message: "hello, world"}, params[:callback])
    end

    # Statuses
    post '/statuses/update' do
      json = StatusesController.update(@auth, params)
      Response.create(json, params[:callback])
    end

    delete %r{^/statuses/destroy/([1-9][0-9]*)$} do
      json = StatusesController.destroy(@auth, params)
      Response.create(json, params[:callback])
    end

    get '/statuses/timeline' do
      json = StatusesController.timeline(params)
      Response.create(json, params[:callback])
    end

    get %r{^/statuses/show/([1-9][0-9]*)$} do
      json = StatusesController.show(params)
      Response.create(json, params[:callback])
    end
  end
end
