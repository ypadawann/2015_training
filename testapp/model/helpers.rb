
require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

module Model
  class Helper
    DELIMITER = '$'
    HASH_ITERATIONS = 1000

    class <<self
      private
      
      def hash(password, salt)
        password += salt
        HASH_ITERATIONS.times do
          password = Digest::SHA256.hexdigest(password)
        end
        password
      end
      
      def salt_and_hash(password)
        salt = SecureRandom.base64(24).to_s
        hashed = hash(password, salt)
        "#{hashed}#{DELIMITER}#{salt}"
      end
      
      def verify_password(stored, password)
        correct_hash, salt = stored.split(DELIMITER)
        correct_hash == hash(password, salt)
      end

      public 
      def start_verify(stored, password)
        verify_password(stored, password)
      end

      def start_hash(password)
        salt_and_hash(password)
      end

    end
  end
end
