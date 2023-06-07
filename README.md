# ruby-minigraph

[![Gem Version](https://badge.fury.io/rb/ruby-minigraph.svg)](https://badge.fury.io/rb/ruby-minigraph)
[![test](https://github.com/kojix2/ruby-minigraph/actions/workflows/ci.yml/badge.svg)](https://github.com/kojix2/ruby-minigraph/actions/workflows/ci.yml)
[![Docs Latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://kojix2.github.io/ruby-minigraph/)
[![The MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)
[![DOI](https://zenodo.org/badge/339645970.svg)](https://zenodo.org/badge/latestdoi/339645970)

:curly_loop: [minigraph](https://github.com/lh3/minigraph) - the sequence-to-graph mapper - for [Ruby](https://github.com/ruby/ruby)

:construction: under development

## Installation

```sh
gem install ruby-minigraph
```

<details>
<summary><b>Compiling from source</b></summary>

```sh
git clone --recursive https://github.com/kojix2/ruby-minigraph
cd ruby-minigraph
bundle install
bundle exec rake minigraph:build
bundle exec rake install
```

</details>

## Quick Start

```ruby
require "minigraph"

Minigraph.execute("--version")
```

## APIs

Only low-level functions are provided at this time.

```ruby
require "minigraph"

MG = Minigraph

n_threads = 4

target = "ext/minigraph/test/MT-human.fa"
queries = ["ext/minigraph/test/MT-orangeA.fa"]

opt = MG::FFI::MapOpt.new
ipt = MG::FFI::IdxOpt.new
gpt = MG::FFI::GGOpt.new

MG::FFI.mg_opt_set(0, ipt, opt, gpt)

g = MG::FFI.gfa_read(target)

ptr = FFI::MemoryPointer.new(:pointer, queries.length)
ptrs = queries.map{ FFI::MemoryPointer.from_string(_1) }
ptr.write_array_of_pointer(ptrs)

MG::FFI.mg_map_files(g, 1, ptr, ipt, opt, n_threads)

MG::FFI.gfa_destroy(g)
```

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
