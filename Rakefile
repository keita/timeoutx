require 'rubygems'
require 'rtask'

#
# RTask
#

RTask.new

#
# bacon
#

desc "Run the specs"
task :spec do
  sh "bacon spec/timeoutx_spec.rb"
end

desc "Default task is to run specs"
task :default => :spec
