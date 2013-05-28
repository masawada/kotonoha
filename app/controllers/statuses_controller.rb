# coding: utf-8
# Author: Masayoshi Wada (@masawada)

module Kotonoha
  module StatusesController
    def self.update(auth, queries)
      begin
        user = Models::User.find(auth.user.id)
      rescue ActiveRecord::RecordNotFound
        raise ERR::UserNotFound
      end

      leaf = Models::Leaf.new
      leaf.text = queries["text"]
      leaf.user = user
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
