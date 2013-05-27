# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'uri'

module Kotonoha
  module Utils
    def self.decode_queries(raw_queries)
      queries = {}
      raw_queries.each{|key, value| queries[key] = self.uri_decode(value) unless key == "captures" || key == "splat"}
      queries
    end

    def self.uri_encode(string)
      URI.escape(string.to_s,/[^-_.!~*'()a-zA-Z\d]/u)
    end

    def self.uri_decode(string)
      URI.decode(string)
    end
  end
end

