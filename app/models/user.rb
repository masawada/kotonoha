# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/activerecord'
require_relative '../../db/connection.rb'

module Kotonoha
  module Models
    class User < ActiveRecord::Base
      validates :name,
        :presence => true,
        :uniqueness => true,
        :length => { :minimum => 1, :maximum => 64 }
    end
  end
end
