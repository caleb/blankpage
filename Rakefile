# frozen_string_literal: true

require 'minitest/test_task'
require 'rake/extensiontask'
require 'rake/clean'
require 'rbconfig'

NAME = 'blankpage'
LIB_DIR = "lib/#{NAME}"
EXT_BUNDLE = "#{LIB_DIR}/#{NAME}.#{RbConfig::CONFIG['DLEXT']}"

EXT_PATH = "ext/#{NAME}"

task :irb do
  sh 'irb -I lib -r blankpage'
  sh 'reset'
end

task runthru: %i[clean default test]

Rake::ExtensionTask.new(NAME) do |extension|
  extension.lib_dir = LIB_DIR
  extension.source_pattern = '*.{c,cc,h}'
end

task :chmod do
  File.chmod(0o0775, EXT_BUNDLE)
end

CLEAN.include(['*.png', '*.gem'])

Minitest::TestTask.create

task build: %i[clean compile chmod]
task default: :compile
