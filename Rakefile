%w[rubygems rake rake/clean rake/testtask fileutils].each { |f| require f }
#require File.dirname(__FILE__) + '/lib/simplepay'

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/test_*.rb'
  t.libs << 'lib'
  t.libs << 'test'
  t.verbose = true
end

task :default => [:test]
#task :release_and_update => [:gemspec, :release, :website, :post_news]
