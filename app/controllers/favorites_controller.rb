# coding: utf-8
# Author: Masayoshi Wada (@masawada)

module Kotonoha
  module FavoritesController
    def self.create(queries)
      leaf_id = queries["captures"].first

      begin
        leaf = Models::Leaf.find(leaf_id)
      rescue ActiveRecord::RecordNotFound
        raise ERR::LeafNotFound
      rescue
        raise ERR::InternalServerError
      end

      leaf.favorites += 1
      leaf.save

      {
        status: {
          id: leaf.id,
          text: leaf.text,
          user_id: leaf.user.id,
          user_name: leaf.user.name,
          favorites: leaf.favorites,
          timestamp: leaf.created_at.to_i
        }
      }
    end
  end
end
