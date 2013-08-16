require 'cgi'
require 'uri'
require 'oauth2'
require 'omniauth'
require 'timeout'
require 'securerandom'
require 'omniauth-oauth2'

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


      # def authorize_params
      #   super.tap do |params|
      #     %w[scope client_options].each do |v|
      #       if request.params[v]
      #         params[v.to_sym] = request.params[v]
      #       end
      #     end
      #   end
      # end

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

      # def raw_info
      #   access_token.options[:mode] = :query
      #   @raw_info ||= access_token.get('user').parsed
      # end


      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/nudge/api/users/@me').parsed
      end

    end
  end
end


OmniAuth.config.add_camelization 'jawbone', 'Jawbone'
