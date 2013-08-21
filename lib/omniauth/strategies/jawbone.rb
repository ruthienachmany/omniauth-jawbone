require 'cgi'
require 'uri'
require 'oauth2'
require 'omniauth'
require 'timeout'
require 'securerandom'
require 'omniauth-oauth2'

module OmniAuth #here I'm inheriting behaviors from the OmniAuth module
  module Strategies #here I'm inheriting behaviors from the Omniauth::Strategies module
    class Jawbone < OmniAuth::Strategies::OAuth2 #declaring a class for my new OmniAuth strategy
      #include OmniAuth::Strategy 

      option :client_options, {
        :site => 'https://jawbone.com',
        :authorize_url => '/auth/oauth2/auth',
        :response_type => 'code',
        :scope => 'basic_read' 'sleep_read',
        :token_url => '/auth/oauth2/token'
        }

      uid { raw_info['xid'].to_s }

      info do
        {
          'id' => raw_info['xid'],
          'photo' => raw_info['photo'],
          'first_name' => raw_info['first'],
          'last_name' => raw_info['last'],
        }
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
