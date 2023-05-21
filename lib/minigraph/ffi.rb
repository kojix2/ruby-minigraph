# frozen_string_literal: true

# bit fields
require "ffi/bit_struct"

module Minigraph
  # Native APIs
  module FFI
    extend ::FFI::Library
    begin
      ffi_lib Minigraph.ffi_lib
    rescue LoadError => e
      raise LoadError, "Could not find #{Minigraph.ffi_lib} \n#{e}"
    end

    # Continue even if some functions are not found.
    def self.attach_function(*)
      super
    rescue ::FFI::NotFoundError => e
      warn e.message
    end
  end
end

require_relative "ffi/constants"
require_relative "ffi/functions"
require_relative "ffi/mappy"
