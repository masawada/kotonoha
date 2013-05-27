# coding: utf-8
# Author: Masayoshi Wada (@masawada)

require 'sinatra/activerecord'
require_relative '../../db/connection.rb'

module Kotonoha
  module Models
    class Leaf < ActiveRecord::Base
      self.table_name = 'leaves'
      belongs_to :user

      validates :text,
        :presence => true
      validates :user,
        :presence => true
      validates :favorites,
        :presence => true,
        :numericality => { :greater_than_or_equal_to => 0 }
    end
  end
end
