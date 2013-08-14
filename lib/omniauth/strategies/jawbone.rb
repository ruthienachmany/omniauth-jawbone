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

attr_accessible :first_name, :last_name, :token, :xid

      option :client_options, {
        :site => 'https://jawbone.com',
        :authorize_url => '/auth/oauth2/auth',
        :token_url => '/auth/oauth2/token'
        }

      def request_phase
        Omniauth::Form.build url:callback_url do 
    <%= form_tag "https://jawbone.com/auth/oauth2/auth", :method => "GET" do %>
    <%= hidden_field_tag 'client_id', ENV["JAWBONE_CLIENT_ID"] %>
    <%= hidden_field_tag 'response_type', 'code' %>
    <%= hidden_field_tag 'scope', 'basic_read sleep_read' %>
    <%= hidden_field_tag 'redirect_uri', "http://www.gitsleep.com/auth" %>
    <%= submit_tag "Go get token and brb" %>
   end
end

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

 credentials do
        
        hash = {'token' => access_token.token}
        hash.merge!('refresh_token' => access_token.refresh_token) if access_token.expires? && access_token.refresh_token
        hash.merge!('expires_at' => access_token.expires_at) if access_token.expires?
        hash.merge!('expires' => access_token.expires?)
        hash
      end


      def user_data
        access_token.options[:mode] = :query
        user_data ||= access_token.get('/nudge/api/users/@me').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'jawbone', 'Jawbone'