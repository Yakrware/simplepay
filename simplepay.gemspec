# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simplepay-rails4"
  s.version = "0.4.0"

  s.authors = ["Nathaniel E. Bibler", "Derrick Parkhurst", "Charles DuBose"]
  s.email = ['gem@nathanielbibler.com', 'gem@dubo.se']
  
  s.summary = "Amazon SimplePay helpers for Rails 4"
  
  s.homepage = 'https://github.com/Yakrware/simplepay'
  s.license  = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  
  s.add_dependency('rails')
  s.add_dependency('nokogiri')
end

