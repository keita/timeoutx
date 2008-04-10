require 'rubygems'
require 'rake'
require 'yaml'
require 'fileutils'

require File.join(File.dirname(__FILE__), 'lib', 'timeoutx')

#
# RubyForge
#

$config =
  YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))

#
# Clean
#

require 'rake/clean'

CLEAN.include ['**/.*.sw?', '*.gem', '.config', '**/.DS_Store']

#
# RDoc
#

require 'rake/rdoctask'

Rake::RDocTask.new do |doc|
  doc.title = "TimeoutX-#{TimeoutX::VERSION} documentation"
  doc.main = "README.txt"
  doc.rdoc_files.include("{README,History,License}.txt", "lib/**/*.rb")
  doc.options << "--line-numbers" << "--inline-source"
end

require 'rake/contrib/rubyforgepublisher'

desc "Upload API documentation"
task :publish do
  Rake::RubyForgePublisher.new("timeoutx", $config["username"])
#   host = "#{$config["username"]}@rubyforge.org"
#   remote_dir = "/var/www/gforge-projects/#{PATH}/"
#   local_dir = 'website'
#   sh %{rsync -aCv #{local_dir}/ #{host}:#{remote_dir}}
end

#
# Release
#

desc 'Release new gem version'
task :deploy => [:check_version, :release] do
  puts "Tagging release #{CHANGES}"
end

task :check_version do
  unless ENV['VERSION']
    puts 'Must pass a VERSION=x.y.z release version'
    exit
  end
  unless ENV['VERSION'] == TimeoutX::VERSION
    puts "Please update the release version, currently #{VERS}"
    exit
  end
end

#
# create gem
#

desc "Create the gem package"
task :gem do
  sh "gemify -I"
end

#
# bacon
#

desc "Run the specs"
task :spec do
  sh "bacon spec/timeoutx_spec.rb"
end

desc "Default task is to run specs"
task :default => :spec
