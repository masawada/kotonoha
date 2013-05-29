# coding: utf-8
# Author: Masayoshi Wada

module Kotonoha
  module SearchController
    def self.search(queries)
      keywords = queries["keywords"].split(' ')
      raise ERR::BadRequest if queries["keywords"].nil?

      max_id = queries["max_id"]
      since_id = queries["since_id"]
      count = queries["count"]
      count = 20 if count.nil?

      begin
        leaves = Models::Leaf.order('id desc')

        keywords.each do |keyword|
          leaves = leaves.where('text like ?', "%#{keyword}%")
        end

        leaves = leaves.where('id < :max_id', {:max_id => max_id}) unless max_id.nil?
        leaves = leaves.where('id < :since_id', {:since_id => since_id}) unless since_id.nil?
        leaves = leaves.limit(count)

      rescue ActiveRecord::RecordNotFound
        raise ERR::LeafNotFound
      rescue
        raise ERR::InternalServerError
      end

      response_array = {}

      leaves.each do |leaf|
        response_array[leaf.id] = {
          id: leaf.id,
          text: leaf.text,
          user_id: leaf.user.id,
          user_name: leaf.user.name,
          favorites: leaf.favorites,
          timestamp: leaf.created_at.to_i
        }
      end

      { statuses: response_array }
    end
  end
end
