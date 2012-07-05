# Pori

A command line toos for Bitbucket to create, delete private repository.(only git)

## Installation

Add this line to your application's Gemfile:

    gem 'pori'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pori

## Usage

### create repository

    $ cd path/to/local-git-directory
    $ pori

### delete repository

    $ cd path/to/local-git-directory
    $ pori delete

## Requirements

 * [Git](http://git-scm.com/)
 * [cURL](http://curl.haxx.se/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
