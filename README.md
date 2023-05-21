# ruby-minigraph

[![Gem Version](https://badge.fury.io/rb/ruby-minigraph.svg)](https://badge.fury.io/rb/ruby-minigraph)
[![test](https://github.com/kojix2/ruby-minigraph/actions/workflows/ci.yml/badge.svg)](https://github.com/kojix2/ruby-minigraph/actions/workflows/ci.yml)
[![Docs Latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://kojix2.github.io/ruby-minigraph/)
[![The MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)
[![DOI](https://zenodo.org/badge/339645970.svg)](https://zenodo.org/badge/latestdoi/339645970)

:curly_loop: [minigraph](https://github.com/lh3/minigraph) - the sequence-to-graph mapper - for [Ruby](https://github.com/ruby/ruby)

:construction: under development

## Installation

You need to install it from the source code. Because you need to build minigraph and create a shared library. Open your terminal and type the following commands in order. 

```sh
git clone --recursive https://github.com/kojix2/ruby-minigraph
cd ruby-minigraph
bundle install
bundle exec rake minigraph:build
bundle exec rake install
```

You can run tests to see if the installation was successful. 

```
bundle exec rake test
```

## Quick Start

```ruby
require "minigraph"
```

## APIs

## Development

```sh
git clone --recursive https://github.com/kojix2/ruby-minigraph
# git clone https://github.com/kojix2/ruby-minigraph
# cd ruby-minigraph
# git submodule update -i
cd ruby-minigraph
bundle install
bundle exec rake minigraph:build
bundle exec rake test
```

## Contributing

ruby-minigraph is a library under development and there are many points to be improved. 
If you improve the source code, please feel free to send us your pull request. 
Typo corrections are also welcome. 

Bug reports and pull requests are welcome on GitHub at https://github.com/kojix2/ruby-minigraph.

## License

[MIT License](https://opensource.org/licenses/MIT).
