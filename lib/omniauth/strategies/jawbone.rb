require 'cgi'
require 'uri'
require 'oauth2'
require 'omniauth'
require 'timeout'
require 'securerandom'

module OmniAuth
  module Strategies
    # Authentication strategy for connecting with APIs constructed using
    # the [OAuth 2.0 Specification](http://tools.ietf.org/html/draft-ietf-oauth-v2-10).
    # You must generally register your application with the provider and
    # utilize an application id and secret in order to authenticate using
    # OAuth 2.0.
    class Jawbone
      include OmniAuth::Strategy

      option :client_options, {
        :site => 'https://jawbone.com',
        :authorize_url => '/auth/oauth2/auth',
        :token_url => '/auth/oauth2/token'
        }

      def request_phase
        super
      end


      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'xid' => raw_info['xid'],
          'photo' => raw_info['photo'],
          'first_name' => raw_info['first'],
          'last_name' => raw_info['last'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end


      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/nudge/api/users/@me').parsed
      end

    end
  end
end


OmniAuth.config.add_camelization 'jawbone', 'Jawbone'

      # option :client_options, {
      #   :site => 'https://jawbone.com',
      #   :authorize_url => '/auth/oauth2/auth',
      #   :token_url => '/auth/oauth2/token'
      #   }


 #      def client
 #        ::OAuth2::Client.new(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], :site => 'https://jawbone.com', :authorize_url => '/auth/oauth2/auth', :token_url => '/auth/oauth2/token')
 #      end



 #      # def request_phase
 #      #   Omniauth::Form.build url:callback_url do 
 #      #     #text_field  'client_id', 'ENV["CLIENT_ID"]'
 #      #     text_field 'response_type', 'code'
 #      #     text_field 'scope', 'basic_read sleep_read'
 #      #     text_field 'redirect_uri', "http://www.gitsleep.com/auth"
 #      #   end
 #      # end

 #  # def self.temporary_code_to_token(code)
 #  #   json = HTTParty.post(
 #  #     "https://jawbone.com/auth/oauth2/token",
 #  #     :body => {
 #  #       :client_id => ENV["CLIENT_ID"],
 #  #       :client_secret => ENV["CLIENT_SECRET"],
 #  #       :grant_type => "authorization_code",
 #  #       :code => code
 #  #     }
 #  #   ).body
 #  #   return JSON.parse(json)["access_token"]
 #  # end

 #  # def self.token_to_user_info(token)
 #  #   HTTParty.get(
 #  #     "https://jawbone.com/nudge/api/users/@me",
 #  #     :headers => {
 #  #       "Authorization" => "Bearer #{token}"
 #  #       }
 #  #   )["data"]
 #  # end

 # credentials do
        
 #        hash = {'token' => access_token.token}
 #        hash.merge!('refresh_token' => access_token.refresh_token) if access_token.expires? && access_token.refresh_token
 #        hash.merge!('expires_at' => access_token.expires_at) if access_token.expires?
 #        hash.merge!('expires' => access_token.expires?)
 #        hash
 #      end


 #      def user_data
 #        access_token.options[:mode] = :query
 #        user_data ||= access_token.get('/nudge/api/users/@me').parsed
 #      end

#     end
#   end
# end


      # uid { user_data['xid'] }

      #     info do
      #       {
      #         token = token
      #         photo = user_info["image"]
      #         first_name = user_info["first"]
      #         last_name = user_info["last"]
      #        }
      #     end
