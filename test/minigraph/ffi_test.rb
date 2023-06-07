# frozen_string_literal: true

require_relative "../test_helper"

class FFITest < Minitest::Test
  def test_mg_idxopt
    io = Minigraph::FFI::IdxOpt.new
    assert_equal 0, io[:k]
    assert_equal 0, io[:w]
    assert_equal 0, io[:bucket_bits]
    Minigraph::FFI.mg_idxopt_init(io)
    assert_equal 17, io[:k]
    assert_equal 11, io[:w]
    assert_equal 14, io[:bucket_bits]
  end

  def test_mg_mapopt
    mo = Minigraph::FFI::MapOpt.new
    assert_equal 0, mo[:seed]
    Minigraph::FFI.mg_mapopt_init(mo)
    assert_equal 11, mo[:seed]
    assert_equal 50, mo[:occ_max1]
    assert_equal 250, mo[:occ_max1_cap]
    #assert_equal 2e-4f, mo[:occ_max1_frac]
    assert_equal 5000, mo[:max_gap]
    assert_equal -1, mo[:max_gap_ref]
    assert_equal 1000, mo[:max_gap_pre]
    assert_equal 25, mo[:max_lc_skip]
    assert_equal 25, mo[:max_gc_skip]
    assert_equal 5000, mo[:max_lc_iter]
    assert_equal 500, mo[:bw]
    assert_equal 20000, mo[:bw_long]
    assert_equal 100000, mo[:rmq_size_cap]
    assert_equal 1000, mo[:rmq_rescue_size]
    assert_in_epsilon 0.1, mo[:div]
    assert_in_epsilon 1.0, mo[:chn_pen_gap]
    assert_in_epsilon 0.05, mo[:chn_pen_skip]
    assert_equal 5, mo[:min_lc_cnt]
    assert_equal 40, mo[:min_lc_score]
    assert_equal 5, mo[:min_gc_cnt]
    assert_equal 50, mo[:min_gc_score]
    assert_equal 10000, mo[:gdp_max_ed]
    assert_equal 50, mo[:lc_max_trim]
    assert_equal 2, mo[:lc_max_occ]
    assert_in_epsilon 0.5, mo[:mask_level]
    assert_equal 6, mo[:sub_diff]
    assert_equal 5, mo[:best_n]
    assert_in_epsilon 0.8, mo[:pri_ratio]
    assert_equal 0, mo[:ref_bonus]
    assert_equal 0, mo[:pe_ori]
    assert_equal 20, mo[:min_cov_mapq]
    assert_equal 1000, mo[:min_cov_blen]
    assert_equal 1000000000, mo[:cap_kalloc]
  end

  def test_mg_ggopt
    go = Minigraph::FFI::GGOpt.new
    Minigraph::FFI.mg_ggopt_init(go)
    assert_equal Minigraph::FFI::G_NONE, go[:algo]
    assert_equal 1, go[:flag]
    assert_equal 100000, go[:min_map_len]
    assert_equal 20000, go[:min_depth_len]
    assert_equal 5, go[:min_mapq]
    assert_equal 50, go[:min_var_len]
    assert_equal 10, go[:match_pen]
    assert_equal 9, go[:ggs_shrink_pen]
    assert_equal 10, go[:ggs_min_end_cnt]
    assert_in_epsilon 0.1, go[:ggs_min_end_frac]
    assert_in_epsilon 0.8, go[:ggs_max_iden]
    assert_in_epsilon 0.95, go[:ggs_min_inv_iden]
  end
end
