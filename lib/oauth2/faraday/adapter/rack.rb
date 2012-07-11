module OAuth2
  module Faraday
    module Adapter
      module Rack

        def call(env)
          if env[:body].is_a?(Hash)
            env[:body] = hash_to_querystring(env[:body])
          end

          super
        end

        def hash_to_querystring(hash)
          hash.keys.inject('') do |query_string, key|
            query_string << '&' unless key == hash.keys.first
            query_string << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
          end
        end

      end
    end
  end
end

::Faraday::Adapter::Rack.send :include, OAuth2::Faraday::Adapter::Rack