# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'json'

module Kotonoha
  module Response
    def self.create(json, callback)
      json[:is_success] = true
      response_body = JSON.generate(json)
      response_body = "#{callback}(#{response_body})" unless callback.nil?
      response_body
    end

    def self.error(code, message, callback)
      json = {
        is_success: false,
        error_code: code,
        error_message: message
      }

      response_body = JSON.generate(json)
      response_body = "#{callback}(#{response_body})" unless callback.nil?
      response_body
    end
  end
end
