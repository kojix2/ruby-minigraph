module Minigraph
  module FFI
    attach_function \
      :mg_verbose_level,
      [:int],
      :int
  end
end
