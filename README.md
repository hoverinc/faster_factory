# Faster Factory

_Make FactoryBot factories go faster_

`Faster Factory` finds `FactoryBot` factories and replaces them with faster methods.
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

## Requirements

**Highly encouraged requirement:** `git`

`Faster Factory` uses the `test && commit || revert` (TCR) methodology
for trying a small change, running the tests, then keeping the change if the tests pass,
or throwing the change away if the tests fail/error.

Because of this, it really works best to use `Faster Factory` in the context of a git repository.

**Highly encouraged:** only use this on a feature/topic branch, not `master`.

That way, if something goes sideways in an unexpected way, you can rollback the changes,
throw them away, or use `git bisect` to find the first bad commit.

## Usage

Work in progress:

Display `Faster Factory` help options.

`faster_factory`
`faster_factory help`
`faster_factory -h`
`faster_factory --help`

Run `Faster Factory` on all files in `spec/` or `test/`,
auto-correcting and committing the changes that succeed.
`faster_factory run`

Run `Faster Factory` on all files on only specified folder or files,
auto-correcting and committing the changes that succeed.

`faster_factory run path/to/folder/or/file`

Run `Faster Factory` with a custom git commit message.
The default commit message are:
  - `[TCR] Replace FactoryBot.create with FactoryBot.build in {{file}}`
  - `[TCR] Replace FactoryBot.build with FactoryBot.build_stubbed in {{file}}`

`faster_factory run --message "Makes {{file}} tests run faaaaster"`

Run `Faster Factory` with a different test strategy.
By default, `Faster Factory` only runs the localized test around the change.
Eg, `rspec spec/user_spec.rb:37`, if the change is on line `37`

If you prefer to run more tests with each change, you can.
Options are: `line`, `file`, `all`.

`faster_factory run --strategy file`

You can combine strategies with a comma to try one first, then double check with something larger.
Eg, `line,file` will run `rspec spec/user_spec.rb:37`, then if it passes `rspec spec/user_spec.rb`.
Eg, `line,all` will run `rspec spec/user_spec.rb:37`, then if it passes `rspec`.

`faster_factory run --strategy file,all`

Run `Faster Factory` without committing successful changes to git.

`faster_factory run --no-git`

Run `Faster Factory` without keeping changes. Instead, generate a report of successful changes.

`faster_factory run --dry-run`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/veganstraightedge/faster_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Faster Factory project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/veganstraightedge/faster_factory/blob/master/CODE_OF_CONDUCT.md).
