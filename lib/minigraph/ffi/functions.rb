# frozen_string_literal: true

module Minigraph
  module FFI
    # options
    attach_function \
      :mg_opt_set,
      [:string, IdxOpt.by_ref, MapOpt.by_ref, GGOpt.by_ref],
      :int

    attach_function \
      :mg_opt_check,
      [IdxOpt.by_ref, MapOpt.by_ref, GGOpt.by_ref],
      :int

    attach_function \
      :mg_opt_update,
      [Idx.by_ref, MapOpt.by_ref, GGOpt.by_ref],
      :void

    # index operations
    attach_function \
      :mg_index,
      [:pointer, IdxOpt.by_ref, :int, MapOpt.by_ref], # FIXME: gfa_t
      Idx.by_ref

    attach_function \
      :mg_idx_destroy,
      [Idx.by_ref],
      :void

    # mapping
    attach_function \
      :mg_tbuf_init,
      [:void],
      TBuf.by_ref

    attach_function \
      :mg_tbuf_destroy,
      [TBuf.by_ref],
      :void

    attach_function \
      :mg_map,
      [Idx.by_ref, :int, :string, TBuf.by_ref, MapOpt.by_ref, :string],
      GChains.by_ref

    attach_function \
      :mg_map_frag,
      [Idx.by_ref, :int, :pointer, :pointer, :pointer, TBuf.by_ref, MapOpt.by_ref, :string],
      :void

    # high-level mapping APIs
    attach_function \
      :mg_map_files,
      [:pointer, :int, :pointer, IdxOpt.by_ref, MapOpt.by_ref, :int], # FIXME gfa_t
      :int

    # graph generation
    attach_function \
      :mg_ggen,
      [:pointer, :int32_t, :pointer, IdxOpt.by_ref, MapOpt.by_ref, GGOpt.by_ref, :int], # FIXME gfa_t
      :int
  end
end
