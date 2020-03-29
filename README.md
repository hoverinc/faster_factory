# Faster Factory

_Make FactoryBot factories go faster_

`FasterFactory` finds `FactoryBot` factories and replaces them with faster methods.
It prefers `FactoryBot.build_stubbed` over `FactoryBot.build` over `FactoryBot.create`.
It doesn't change your tests in any other way.
It changes one occurrence at a time, then runs the localized test for that change.
If the tests pass, it commits the change.
If they fails, it reverts the change.

Largely inspired by [factory_faster](https://github.com/livingsocial/factory_faster) by [Tom Copeland](https://github.com/tcopeland).

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'faster_factory'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install faster_factory
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/veganstraightedge/faster_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FasterFactory project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/veganstraightedge/faster_factory/blob/master/CODE_OF_CONDUCT.md).
