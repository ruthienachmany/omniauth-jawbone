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
      # option :authorize_params, {}
      # option :authorize_options, [:scope]
      # option :auth_token_params, {}

      # def request_phase
      #   super
      # end

      # uid{ user_data['id'] }

      info do
        {
          'basic_read' => user_data['basic_read']
        }
      end
#josh rowley
       def request_phase
        options[:authorize_params] = {
          :name => options['app_name'],
          :scope => options['scope'] || 'read'
        }
        options[:authorize_params].merge!(:expiration => options['expiration']) if options['expiration']
        super
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/1/members/me').body)
      end
#josh rowley
    
#git sleep
  attr_accessible :first_name, :last_name, :token, :xid
  
  def self.temporary_code_to_token(code)
    json = HTTParty.post(
      "https://jawbone.com/auth/oauth2/token",
      :body => {
        :client_id => ENV["JAWBONE_CLIENT_ID"],
        :client_secret => ENV["JAWBONE_SECRET"],
        :grant_type => "authorization_code",
        :code => code
      }
    ).body
    return JSON.parse(json)["access_token"]
  end

  def self.token_to_user_info(token)
    HTTParty.get(
      "https://jawbone.com/nudge/api/users/@me",
      :headers => {
        "Authorization" => "Bearer #{token}"
        }
    )["data"]
  end
#end

      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/nudge/api/users/@me').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'jawbone', 'Jawbone'