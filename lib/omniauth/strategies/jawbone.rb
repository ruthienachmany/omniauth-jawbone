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
    class Jawbone < OmniAuth::Strategy
      option :client_options, {
        :site => 'https://jawbone.com',
        :authorize_url => '/auth/oauth2/auth',
        :token_url => '/auth/oauth2/auth/token'
      }
      

      def request_phase
        super
      end

      uid{ user_data['id'] }

      info do
        {
          'basic_read' => user_data['basic_read']
          'extended_read' => user_data['extended_read']
          'location_read' => user_data['location_read']
          'friends_read' => user_data['friends_read']
          'mood_read' => user_data['mood_read']
          'mood_write' => user_data['mood_write']
          'move_read' => user_data['move_read']
          'move_write' => user_data['move_write']
          'sleep_read' => user_data['sleep_read']
          'meal_read' => user_data['meal_read']
          'meal_write' => user_data['meal_write']
          'weight_read' => user_data['weight_read']
          'weight_write' => user_data['weight_write']
          'cardiac_read' => user_data['cardiac_read']
          'cardiac_write' => user_data['cardiac_write']
          'generic_event_read' => user_data['generic_event_read']
          'generic_event_write' => user_data['generic_event_write']
        },
      end

    
      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/1/me').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'jawbone', 'Jawbone'