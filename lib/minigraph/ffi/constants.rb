# frozen_string_literal: true

module Minigraph
  module FFI
    M_SPLICE       = 0x10
    M_SR           = 0x20
    M_FRAG_MODE    = 0x40
    M_FRAG_MERGE   = 0x80
    M_FOR_ONLY     = 0x100
    M_REV_ONLY     = 0x200
    M_HEAP_SORT    = 0x400
    M_VERTEX_COOR  = 0x800
    M_ALL_CHAINS   = 0x1000
    M_PRINT_2ND    = 0x2000
    M_CAL_COV      = 0x4000
    M_RMQ          = 0x8000
    M_COPY_COMMENT = 0x10000
    M_INDEPEND_SEG = 0x20000
    M_NO_QUAL      = 0x40000
    M_2_IO_THREADS = 0x80000
    M_SHOW_UNMAP   = 0x100000
    M_NO_COMP_PATH = 0x200000
    M_NO_DIAG      = 0x400000
    M_WRITE_LCHAIN = 0x800000
    M_WRITE_MZ     = 0x1000000
    M_SKIP_GCHECK  = 0x2000000

    G_NONE         = 0
    G_GGSIMPLE     = 1

    G_NO_QOVLP     = 0x1
    G_CAL_COV      = 0x2
    G_NO_INV       = 0x4
    G_CALL         = 0x8

    # emulate 128-bit integers
    class MM128 < ::FFI::Struct
      layout \
        :x, :uint64_t,
        :y, :uint64_t
    end

    # emulate 128-bit arrays
    class MM128V < ::FFI::Struct
      layout \
        :n, :size_t,
        :m, :size_t,
        :a, MM128.ptr
    end

    # indexing option
    class IdxOpt < ::FFI::Struct
      layout \
        :k,               :short,
        :w,               :short,
        :bucket_bits,     :short
    end

    class MapOpt < ::FFI::Struct
      layout \
        :flag,             :uint64_t,
        :mini_batch_size,  :int64_t,
        :seed,             :int,
        :max_qlen,         :int,
        :pe_ori,           :int,
        :occ_max1,         :int,
        :occ_max1_cap,     :int,
        :occ_weight,       :int,
        :occ_max1_frac,    :float,
        :bw,               :int,
        :max_gap_pre,      :int,
        :max_gap,          :int,
        :max_gap_ref,      :int,
        :max_frag_len,     :int,
        :div,              :float,
        :chn_pen_gap,      :float,
        :chn_pen_skip,     :float,
        :max_lc_skip,      :int,
        :max_lc_iter,      :int,
        :max_gc_skip,      :int,
        :max_rmq_size,     :int,
        :min_lc_cnt,       :int,
        :min_lc_score,     :int,
        :min_gc_cnt,       :int,
        :min_gc_score,     :int,
        :mask_level,       :float,
        :sub_diff,         :int,
        :best_n,           :int,
        :pri_ratio,        :float,
        :ref_bonus,        :int,
        :max_gc_seq_ext,   :int,
        :min_cov_mapq,     :int,
        :min_cov_blen,     :int
    end

    class GGOpt < ::FFI::Struct
      layout \
        :flag,             :uint64_t,
        :algo,             :int,
        :min_mapq,         :int,
        :min_map_len,      :int,
        :min_depth_len,    :int,
        :min_var_len,      :int,
        # parameters specific to ggsimple/ggs
        :match_pen,        :int,
        :ggs_shrink_pen,   :int,
        :ggs_min_end_cnt,  :int,
        :ggs_min_end_frac, :float,
        # scoring for SW check
        :scmat,            [:int8_t, 25],
        :gapo,             :int8_t,
        :gape,             :int8_t,
        :gapo2,            :int8_t,
        :gape2,            :int8_t,
        :ggs_max_iden,     :float,
        :ggs_min_inv_iden, :float
    end

    class Idx < ::FFI::Struct
      layout \
        :g,                :pointer, # const gfa_t *g
        :b,                :int32_t,
        :w,                :int32_t,
        :k,                :int32_t,
        :flag,             :int32_t,
        :B,                :pointer  # mg_idx_bucket_s *B
    end

    class LChain < ::FFI::BitStruct
      layout \
        :off,              :int32_t,
        :fields,           :int32_t,
        :v,                :uint32_t,
        :rs,               :int32_t,
        :re,               :int32_t,
        :qs,               :int32_t,
        :qe,               :int32_t,
        :score,            :int32_t,
        :dist_pre,         :int32_t,
        :hash_pre,         :uint32_t

      bitfields :fields,
                :cnt, 31,
                :inner_pre, 1
    end

    class LLChain < ::FFI::Struct
      layout \
        :off,              :int32_t,
        :cnt,              :int32_t,
        :v,                :uint32_t,
        :score,            :int32_t
    end

    class GChain < ::FFI::BitStruct
      layout \
        :id,               :int32_t,
        :parent,           :int32_t,
        :off,              :int32_t,
        :cnt,              :int32_t,
        :n_anchor,         :int32_t,
        :score,            :int32_t,
        :qs,               :int32_t,
        :qe,               :int32_t,
        :plen,             :int32_t,
        :ps,               :int32_t,
        :pe,               :int32_t,
        :blen,             :int32_t,
        :mlen,             :int32_t,
        :div,              :float,
        :hash,             :uint32_t,
        :subsc,            :int32_t,
        :n_sub,            :int32_t,
        :fileds,           :uint32_t

      bitfields :fields,
                :mapq,   8,
                :fit,    1,
                :dummy,  23
    end

    class GChains < ::FFI::Struct
      layout \
        :km,               :pointer,
        :n_gc,             :int32_t,
        :n_lc,             :int32_t,
        :n_a,              :int32_t,
        :rep_len,          :int32_t,
        :gc,               :pointer, # FIXME mg_gchain_t
        :lc,               :pointer, # FIXME mg_llchain_t
        :a,                :pointer  # FIXME mg128_t
    end

    class TBuf < ::FFI::Struct
      layout \
        :km,       :pointer,
        :frag_gap, :int
    end
  end
end
