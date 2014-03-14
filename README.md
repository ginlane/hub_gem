spree_hub
========


Installation
------------

Add spree_hub to your Gemfile:

```ruby
gem 'spree_hub', github: 'spree/hub_gem'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_hub:install
```

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_hub/factories'
```

Sample Order Push
-----------------

Note: this will be abstracted soon in `Spree::Hub::Client`

```ruby

Spree::Hub::Config[:hub_store_id] = "34werwerwer"
Spree::Hub::Config[:hub_token] = "sdfsfddfdss"

require 'active_model/serializer'
Spree::Hub::Client.push(ActiveModel::ArraySerializer.new(Spree::Order.complete, each_serializer: Spree::Hub::OrderSerializer, root: 'orders').to_json)
```

Copyright (c) 2014 Spree Commerce, Inc. and other contributors, released under the New BSD License
