# OmniAuth Jawbone

Updated 2013.09.19 to work with the officially released Jawbone API.

This is an OmniAuth strategy for authenticating to Jawbone. To
use it, you'll need to [sign up](https://jawbone.com/up/developer) for an OAuth2 Application ID and Secret.

## Basic Usage

    use OmniAuth::Builder do
      provider :jawbone, 
        ENV['JAWBONE_CLIENT_ID'], 
        ENV['JAWBONE_CLIENT_SECRET'], 
        :scope => "basic_read mood_read"
    end

## Original License

Copyright (c) 2011 Michael Bleigh and Intridea, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
