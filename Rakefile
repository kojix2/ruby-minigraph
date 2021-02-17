# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

namespace :minigraph do
  desc "Compile Minigraph"
  task :build do
    require "ffi"
    Dir.chdir("minigraph") do
      # Add -fPIC option to Makefile
      system "git apply ../minigraph.patch"
      system "make"
      case RbConfig::CONFIG["host_os"]
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        warn "windows not supported"
      when /darwin|mac os/
        system "clang -dynamiclib -undefined dynamic_lookup -o libminigraph.#{FFI::Platform::LIBSUFFIX} *.o"
      else
        system "cc -shared -o libminigraph.so *.o"
      end
      system "git apply -R ../minigraph.patch"
      FileUtils.mkdir_p("../vendor")
      FileUtils.move("libminigraph.#{FFI::Platform::LIBSUFFIX}", "../vendor/libminigraph.#{FFI::Platform::LIBSUFFIX}")
    end
  end

  desc "Cleanup"
  task :clean do
    Dir.chdir("minigraph") do
      system "make clean"
    end
  end
end

namespace :c2ffi do
  desc "Generate metadata files (JSON format) using c2ffi"
  task :generate do
    header_files = FileList["minigraph/**/*.h"]
    header_files.each do |file|
      system "c2ffi #{file}" \
             " -o codegen/native_functions/#{File.basename(file, ".h")}.json"
    end
  end

  desc "Remove metadata files"
  task :remove do
    FileList["codegen/native_functions/*.json"].each do |path|
      File.unlink(path) if File.exist?(path)
    end
  end
end
