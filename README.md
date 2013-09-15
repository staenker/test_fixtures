# TestFixtures

Provides a simple api to get paths to a tests fixture directory based on a convention using the test case files name and directory.

## Installation

Add this line to your application's Gemfile:

    gem 'test_fixtures'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_fixtures

## Usage

Given the following file system tree relative you your projects root directory
```
spec
├── use_cases_spec-fixture
│   ├── hello.txt
│   └── world.txt
├── use_cases_spec-fixtures
│   └── fixture_a
│       ├── are.txt
│       └── you.txt
└── use_cases_spec.rb
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
