require 'spec_helper'
require_relative '../../../lib/omniauth/strategies/jawbone'

describe OmniAuth::Strategies::Jawbone do

  subject do
    OmniAuth::Strategies::Jawbone.new({})
  end

  context "client options" do
    it "should have correct site" do
      subject.options.client_options.site.should eq("https://jawbone.com")
    end

    it "should have correct authorize path" do
      subject.options.client_options.authorize_url.should eq("/auth/oauth2/auth")
    end

    it "should have the correct request token path" do
      subject.options.client_options.token_url.should eq("/auth/oauth2/token")
    end

    it "should have the correct access token path" do
      subject.options.client_options.scope.should eq("basic_readsleep_read")
    end
  end
end