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

    def self.destroy(auth, queries)
      begin
        user = Models::User.find(auth.user.id)
      rescue ActiveRecord::RecordNotFound
        raise ERR::UserNotFound
      end

      raise ERR::BadRequest if queries["captures"].first.nil?

      begin
        leaf = Models::Leaf.find(queries["captures"].first.to_i)
      rescue ActiveRecord::RecordNotFound
        raise ERR::LeafNotFound
      end

      raise ERR::RequestForbidden unless leaf.user.id == user.id
      
      deleted_id = leaf.id
      leaf.destroy

      {
        deleted_id: deleted_id
      }
    end
  end
end
