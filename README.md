# Midjourney

[![Gem Version](https://badge.fury.io/rb/midjourney.svg)](https://badge.fury.io/rb/midjourney)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/alexrudall/midjourney/blob/main/LICENSE.txt)
[![CircleCI Build Status](https://circleci.com/gh/alexrudall/midjourney.svg?style=shield)](https://circleci.com/gh/alexrudall/midjourney)

Use [Midjourney](https://www.midjourney.com/) with Ruby! 🤖🌌

Using [SlashImagine](https://slashimagine.pro/docs) as the API until Midjourney releases their official API (at which point I'll swap it over to that). Please note that this library is unofficial and not affiliated with Midjourney or SlashImagine!

For now you'll need some [SlashImagine](https://slashimagine.pro/pricing) credits to use this library.

[Ruby AI Builders Discord](https://discord.gg/k4Uc224xVD)

[Rails AI Guides](https://railsai.com)

Follow me on [Twitter](https://twitter.com/alexrudall) for more Ruby / AI content!

### Bundler

Add this line to your application's Gemfile:

```ruby
gem "midjourney"
```

And then execute:

$ bundle install

### Gem install

Or install with:

$ gem install midjourney

and require with:

```ruby
require "midjourney"
```

## Usage

- Get your API key from [https://slashimagine.pro/](https://slashimagine.pro/) - click Pricing, sign up to a plan, and then click My Account to see your API key.

### Quickstart

For a quick test you can pass your api key directly to a new client:

```ruby
client = Midjourney::Client.new(access_token: "access_token_goes_here")
```

### With Config

For a more robust setup, you can configure the gem with your API keys, for example in an `midjourney.rb` initializer file. Never hardcode secrets into your codebase - instead use something like [dotenv](https://github.com/motdotla/dotenv) to pass the keys safely into your environments.

```ruby
Midjourney.configure do |config|
    config.access_token = ENV.fetch("MIDJOURNEY_API_KEY")
end
```

Then you can create a client like this:

```ruby
client = Midjourney::Client.new
```

#### Change timeout

The default timeout for any request using this library is 120 seconds. You can change that by passing a number of seconds to the `request_timeout` when initializing the client.

```ruby
client = Midjourney::Client.new(
    access_token: "access_token_goes_here",
    request_timeout: 240 # Optional
)
```

You can also set these keys when configuring the gem:

```ruby
Midjourney.configure do |config|
    config.access_token = ENV.fetch("MIDJOURNEY_API_KEY")
    config.request_timeout = 240 # Optional
end
```

### Imagine

Hit the Midjourney API for an image:

```ruby
response = client.imagine(
    parameters: {
        prompt: "A stunning forest beneath a bright blue sky",
    })
puts response["taskId"]
# => "abc123"
```

### Result

You can use this taskId to check the status of the task and get your image:

```ruby
response = client.result(
    parameters: {
        taskId: "abc123",
    })
puts response["imageURL"]
# => "https://..........png"
```

![Ruby](https://i.ibb.co/gWHG7S8/stunning-forest.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Warning

If you have an `MIDJOURNEY_API_KEY` in your `ENV`, running the specs will use this to run the specs against the actual API, which will be slow and cost you money - 3 credits or more! Remove it from your environment with `unset` or similar if you just want to run the specs against the stored VCR responses.

## Release

First run the specs without VCR so they actually hit the API. This will cost 2 cents or more. Set MIDJOURNEY_API_KEY in your environment or pass it in like this:

```
MIDJOURNEY_API_KEY=123abc bundle exec rspec
```

Then update the version number in `version.rb`, update `CHANGELOG.md`, run `bundle install` to update Gemfile.lock, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/alexrudall/midjourney>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alexrudall/midjourney/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby Midjourney project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alexrudall/midjourney/blob/main/CODE_OF_CONDUCT.md).
