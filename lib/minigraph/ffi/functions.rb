# frozen_string_literal: true

module Minigraph
  module FFI
    attach_function \
      :main,
      %i[int pointer],
      :int

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
      [Idx.by_ref, :int, :pointer, :pointer, GChains.by_ref, TBuf.by_ref, MapOpt.by_ref, :string],
      :void

    # high-level mapping APIs
    attach_function \
      :mg_map_files,
      [:pointer, :int, :pointer, IdxOpt.by_ref, MapOpt.by_ref, :int], # FIXME: gfa_t
      :int

    # graph generation
    attach_function \
      :mg_ggen,
      [:pointer, :int32, :pointer, IdxOpt.by_ref, MapOpt.by_ref, GGOpt.by_ref, :int], # FIXME: gfa_t
      :int

    attach_function \
      :mg_idxopt_init,
      [IdxOpt.by_ref],
      :void
    
    attach_function \
      :mg_mapopt_init,
      [MapOpt.by_ref],
      :void

    attach_function \
      :mg_ggopt_init,
      [GGOpt.by_ref],
      :void

    # gfa.h

    attach_function \
      :gfa_init,
      [:void],
      :pointer # gfa_t *

    attach_function \
      :gfa_destroy,
      [:pointer], # gfa_t *
      :void
    
    attach_function \
      :gfa_read,
      [:string],
      :pointer # gfa_t *

    attach_function \
      :gfa_print,
      [:pointer, :pointer, :int],
      :void
  end
end
