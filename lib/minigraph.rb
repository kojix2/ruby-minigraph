# frozen_string_literal: true

# dependencies
require "ffi"

# modules
require_relative "minigraph/version"

# Minigraph
# https://github.com/lh3/minigraph
# Li, H., Feng, X. & Chu, C. The design and construction of reference pangenome graphs
# with minigraph. Genome Biol 21, 265 (2020). https://doi.org/10.1186

module Minigraph
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end

  lib_name = ::FFI.map_library_name("minigraph")
  self.ffi_lib = if ENV["MINIGRAPHDIR"]
                   File.expand_path(lib_name, ENV["MINIGRAPHDIR"])
                 else
                   File.expand_path("../vendor/#{lib_name}", __dir__)
                 end

  # friendlier error message
  autoload :FFI, "minigraph/ffi"

  class << self
    # Execute minigraph comannd with given options.
    # @overload  execute(arg0,arg1,...)
    # @param [String] arg minigraph command option.
    # @example Get minigraph version
    #   Minigraph.execute('--version')

    def execute(*rb_argv)
      str_ptrs = []
      # First argument is the program name.
      str_ptrs << ::FFI::MemoryPointer.from_string("minigraph")
      rb_argv.each do |arg|
        arg.to_s.split(/\s+/).each do |s|
          str_ptrs << ::FFI::MemoryPointer.from_string(s)
        end
      end
      str_ptrs << nil

      # Load all the pointers into a native memory block
      argv = ::FFI::MemoryPointer.new(:pointer, str_ptrs.length)
      str_ptrs.each_with_index do |p, i|
        argv[i].put_pointer(0, p)
      end

      FFI.main(str_ptrs.length - 1, argv)
    end

    # Get verbosity level.
    # @return [Integer] verbosity level.

    def verbose
      FFI.mg_verbose_level(-1)
    end

    # Set verbosity level.
    # @param [Integer] verbosity level
    # @return [Integer] verbosity level.

    def verbose=(level)
      FFI.mg_verbose_level(level)
    end
  end
end
