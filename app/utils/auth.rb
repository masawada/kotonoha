# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'openssl'
require 'base64'

module Kotonoha
  class Auth
    def authorize?(raw_queries, query_keys, env)
      timestamp, queries, signature = split_raw_queries(raw_queries, query_keys)
      raise ERR::AuthorizationFailed unless time?(timestamp)
      raise ERR::AuthorizationFailed unless permit?(queries, signature, env)
      true
    end

    def user
      @user
    end

    private
    def split_raw_queries(raw_queries, query_keys)
      queries = {}
      query_keys.each do |key|
        queries[key] = raw_queries[key]
      end

      timestamp = raw_queries["timestamp"]
      signature = raw_queries["signature"]

      return timestamp, queries, signature
    end

    def time?(timestamp)
      return false unless /^(\d{4})(-(\d{2})){2}T(\d{2})(:(\d{2})){2}.(\d{3})Z$/ =~ timestamp
      true
    end

    def permit?(queries, signature, env)
      signature == generate_signature(queries, env)
    end

    def generate_signature(queries, env)
      begin
        access_key = queries["access"]
        key = Models::Key.find_by_access(access_key)
        secret_key = key.secret
        @user = key.user

        encoded_queries = []
        queries.sort.each do |k, v|
          encoded_queries << "#{k}=#{uri_encode(v)}"
        end
        query_string = encoded_queries.join("&")

        string_to_hash = [
          uri_encode(env['REQUEST_METHOD']),
          uri_encode(env['HTTP_HOST']),
          uri_encode(env['REQUEST_PATH']),
          query_string
        ].join("\n")

        hmac = OpenSSL::HMAC::hexdigest(OpenSSL::Digest::SHA256.new, secret_key, string_to_hash)
        Base64.strict_encode64(hmac).chomp
      rescue
        nil
      end
    end

    def uri_encode(string)
      Utils.uri_encode(string)
    end

    def decode_queries(queries)
      Utils.decode_queries(queries)
    end
  end
end
