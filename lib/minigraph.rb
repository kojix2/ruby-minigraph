# frozen_string_literal: true

# dependencies
require 'ffi'

# bit fields
require_relative 'minigraph/ffi_helper'

# modules
require_relative 'minigraph/version'

# Minigraph
# https://github.com/lh3/minigraph
# Li, H., Feng, X. & Chu, C. The design and construction of reference pangenome graphs
# with minigraph. Genome Biol 21, 265 (2020). https://doi.org/10.1186
module Minigraph
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end

  lib_name = ::FFI.map_library_name('minigraph')
  self.ffi_lib = if ENV['MINIGRAPHDIR']
                   File.expand_path(lib_name, ENV['MINIGRAPHDIR'])
                 else
                   File.expand_path("../vendor/#{lib_name}", __dir__)
                 end

  # friendlier error message
  autoload :FFI, 'minigraph/ffi'

  class << self
  end
end
