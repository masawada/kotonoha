# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/activerecord'
require_relative '../../db/connection.rb'

module Kotonoha
  module Models
    class Key < ActiveRecord::Base
      belongs_to :user

      validates :access,
        :presence => true,
        :uniqueness => true
      validates :secret,
        :presence => true
    end
  end
end
