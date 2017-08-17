# devise_invalidatable

Adds support for [Devise](http://github.com/plataformatec/devise) to manually invalidate sessions on the server-side.

The core logic was shamelessly copied from [this](http://www.jonathanleighton.com/articles/2013/revocable-sessions-with-devise/) blog post by [@jonleighton](https://github.com/jonleighton). I just packaged it into a Devise extension for easy use.

## Installation

Add `devise_invalidatable` to your Gemfile and install
```
gem 'devise_invalidatable`
```
```
bundle install
```
Run the generator with the name of your Devise resource (e.g. User)
```
rails g devise_invalidatable User
```
This will add the directive to the resource's model and create a migration for the sessions table.

If using Mongoid, run the generator with `--mongoid`
```
rails g devise_invalidatable User --mongoid
```
This will add the directive to the resource's model and create a user session model.

## Copyright

MIT License (MIT)

Copyright 2015 Michael Adkins

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contributors
* Mike Adkins [@madkins](https://github.com/madkins)
* Michael Watts [@mikwat](https://github.com/mikwat)
