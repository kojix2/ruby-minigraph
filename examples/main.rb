require "minigraph"

MG = Minigraph

n_threads = 4

target = ARGV[0]
queries = ARGV[1..-1]

opt = MG::FFI::MapOpt.new
ipt = MG::FFI::IdxOpt.new
gpt = MG::FFI::GGOpt.new

MG::FFI.mg_opt_set(0, ipt, opt, gpt)

g = MG::FFI.gfa_read(target)

ptr = FFI::MemoryPointer.new(:pointer, queries.length)
ptrs = queries.map { FFI::MemoryPointer.from_string(_1) }
ptr.write_array_of_pointer(ptrs)

MG::FFI.mg_map_files(g, 1, ptr, ipt, opt, n_threads)

MG::FFI.gfa_destroy(g)
