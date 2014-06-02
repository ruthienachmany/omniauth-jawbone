# OmniAuth Jawbone

Updated 2013.09.19 to work with the officially released Jawbone API.

This is an OmniAuth strategy for authenticating to Jawbone. To
use it, you'll need to [sign up](https://jawbone.com/up/developer) for an OAuth2 Application ID and Secret.

## Basic Usage

Add the strategy to your `Gemfile`:

```ruby
gem 'omniauth-jawbone'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :jawbone, 
    ENV['JAWBONE_CLIENT_ID'], 
    ENV['JAWBONE_CLIENT_SECRET'], 
    :scope => "basic_read mood_read"
end
```

In Rails, create a new file under config/initializers called omniauth.rb to plug the strategy into your middleware stack.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jawbone, 
    ENV['JAWBONE_CLIENT_ID'], 
    ENV['JAWBONE_CLIENT_SECRET'], 
    :scope => "basic_read mood_read"
end
```

As with other OAuth2 2.0 providers, the token (which you need to get
Jawbone data from their API) is in the (auth
hash)[https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema], in
`request.env["omniauth.auth"]["credentials"]["token"]`.

There will also be provided a refresh token (described (here)[https://nudgestage.jawbone.com/up/developer/authentication]), in `request.env["omniauth.auth"]["credentials"]["refresh_token"]`.

For additional information about OmniAuth, visit [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

For a short tutorial on how to use OmniAuth in your Rails application, visit [this tutsplus.com tutorial](http://net.tutsplus.com/tutorials/ruby/how-to-use-omniauth-to-authenticate-your-users/).

(The above stolen and adapted from (omniauth-fitbit)[https://github.com/tkgospodinov/omniauth-fitbit])

## Original License

Copyright (c) 2011 Michael Bleigh and Intridea, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
