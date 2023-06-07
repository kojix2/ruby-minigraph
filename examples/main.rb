require "minigraph"

MG = Minigraph

n_threads = 4

opt = MG::FFI::MapOpt.new
ipt = MG::FFI::IdxOpt.new
gpt = MG::FFI::GGOpt.new

MG::FFI.mg_opt_set(0, ipt, opt, gpt)

g = MG::FFI.gfa_read(ARGV[0])

ptrs = ARGV[1..-1].map { FFI::MemoryPointer.from_string(_1) }
ptr = FFI::MemoryPointer.new(:pointer, ptrs.length)
ptr.write_array_of_pointer(ptrs)

MG::FFI.mg_map_files(g, ARGV.length - 1, ptr, ipt, opt, n_threads)
# MG::FFI.gfa_sort_ref_arc(g)
# MG::FFI.mg_ggen(g, ARGV.length - 1, ptr, gpt, opt, gpt, n_threads)

MG::FFI.gfa_destroy(g)
