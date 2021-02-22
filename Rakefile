# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test

def cmd
  return @cmd if defined? @cmd

  require 'tty-command'
  @cmd = TTY::Command.new
end

namespace :minigraph do
  desc 'Compile Minigraph'
  task :build do
    Dir.chdir('minigraph') do
      # Add -fPIC option to Makefile
      cmd.run 'git apply ../minigraph.patch'
      cmd.run 'make'
      case RbConfig::CONFIG['host_os']
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        warn 'windows not supported'
      when /darwin|mac os/
        libsuffix = 'dylib'
        cmd.run 'clang -dynamiclib -undefined dynamic_lookup -o libminigraph.dylib *.o'
      else
        libsuffix = 'so'
        cmd.run 'cc -shared -o libminigraph.so *.o'
      end
      cmd.run 'git apply -R ../minigraph.patch'
      cmd.run 'mkdir -p ../vendor'
      cmd.run "mv libminigraph.#{libsuffix} ../vendor/libminigraph.#{libsuffix}"
    end
  end

  desc 'Cleanup'
  task :clean do
    Dir.chdir('minigraph') do
      cmd.run 'make clean'
    end
  end
end

namespace :c2ffi do
  desc 'Generate metadata files (JSON format) using c2ffi'
  task :generate do
    FileUtils.mkdir_p('codegen')
    header_files = FileList['minigraph/**/*.h']
    header_files.each do |file|
      cmd.run "c2ffi #{file}" \
             " -o codegen/#{File.basename(file, '.h')}.json"
    end
  end

  desc 'Remove metadata files'
  task :remove do
    FileList['codegen/native_functions/*.json'].each do |path|
      File.unlink(path) if File.exist?(path)
    end
  end
end
