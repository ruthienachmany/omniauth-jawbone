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
        :token_url => '/auth/oauth2/auth/token'
      }
      option :authorize_params, {}
      option :authorize_options, [:scope]
      option :auth_token_params, {}

      def request_phase
        super
      end

      uid{ user_data['id'] }

      info do
        {
          'basic_read' => user_data['basic_read']
        }
      end

    
      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/nudge/api/users/@me').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'jawbone', 'Jawbone'