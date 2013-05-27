# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'openssl'
require 'base64'

module Kotonoha
  class Auth
    def authorize?(raw_queries)
      timestamp, queries, signature = split_raw_queries(raw_queries)
      raise ERR::AuthorizationFailed unless time?(timestamp)
      raise ERR::AuthorizationFailed unless permit?(queries, signature)
      true
    end

    def user
      @user
    end

    private
    def split_raw_queries(raw_queries)
      queries = decode_queries(raw_queries)
      timestamp = queries["timestamp"]
      signature = queries.delete("signature")

      return timestamp, queries, signature
    end

    def time?(timestamp)
      return false unless /^(\d{4})(-(\d{2})){2}T(\d{2})(:(\d{2})){2}.(\d{3})Z$/ =~ timestamp
      true
    end

    def permit?(queries, signature)
      signature == generate_signature(queries)
    end

    def generate_signature(queries)
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
          uri_encode(ENV['REQUEST_METHOD']),
          uri_encode(ENV['HTTP_HOST']),
          uri_encode(ENV['REQUEST_PATH']),
          query_string
        ].join("\n")

        hmac = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, secret_key, string_to_hash)
        Base64.encode64(hmac).chomp
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
