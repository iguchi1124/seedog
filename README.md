# Seedog
Hyper master data manager for activerecord.

## Usage

### Rails
1. Put `db/Seedfile` on your application.
  ```rb
  # vi: set ft=ruby :

  transaction do
    model User do
      record id: 1 do
        name 'user 1'
      end

      record id: 2 do
        name 'user 2'
      end
    end

    model Profile do
      record user_id: 1 do
        biography 'bio 1'
      end
    end

    model Article do
      record id: 1, user_id: 1 do
        title 'welcome!'
        body 'this is first article!'
      end
    end
  end
  ```
2. Run `bundle exec rails db:seed` or `bundle exec rails db:seed:dry-run`

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'seedog'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install seedog
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
