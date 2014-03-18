# EnumAasm

An extension to the [AASM](https://github.com/aasm/aasm) finite state machine that uses
[PowerEnum](https://github.com/albertosaurus/power_enum_2) enumerated attributes
for state transitions.

## Installation

Add this line to your application's Gemfile:

    gem 'enum_aasm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum_aasm

## Usage

Basically the same usage as the original AASM. The only difference is that the `:column` option is mandatory.
Use this option to specify the name of the enumerated attribute. Note that scopes are not defined
by the state machine as PowerEnum already handles this functionality.

### Example

```ruby
require 'enum_aasm'

class Fruit < ActiveRecord::Base
  include AASM

  has_enumerated :fruit_color

  aasm :column => :fruit_color do
    state :green, :initial => true
  end
end
```

## License

Distributed under the MIT license. See LICENSE.txt for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright 2014 Arthur Shagall
