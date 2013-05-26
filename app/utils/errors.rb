# coding: utf-8
# Author: Masayoshi Wada (@masawada)

module Kotonoha
  module ERR
    class BadRequest < StandardError
      def self.code
        400
      end

      def self.message
        "Bad Request: Confirm request queries."
      end
    end

    class AuthorizationFailed < StandardError
      def self.code
        401
      end

      def self.message
        "Authorization Failed: Confirm your access key or secret key."
      end
    end

    class RequestForbidden < StandardError
      def self.code
        403
      end

      def self.message
        "Request Forbidden."
      end
    end

    class NotFound < StandardError
      def self.code
        404
      end

      def self.message
        "Resource not found."
      end
    end

    class UserNotFound < StandardError
      def self.code
        404
      end

      def self.message
        "User not found."
      end
    end

    class LeafNotFound < StandardError
      def self.code
        404
      end

      def self.message
        "Leaves not found."
      end
    end

    class InternalServerError < StandardError
      def self.code
        500
      end

      def self.message
        "Internal Server Error."
      end
    end
  end
end
