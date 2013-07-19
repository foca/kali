# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kali/version"

Gem::Specification.new do |spec|
  spec.name        = "kali"
  spec.version     = Kali::VERSION
  spec.date        = Date.today
  spec.summary     = "Implementation of the iCalendar standard"
  spec.description = "Extensible implementation of RFC5545. Also known as 'iCalendar'"
  spec.authors     = ["Nicolas Sanguinetti"]
  spec.email       = ["hi@nicolassanguinetti.info"]
  spec.homepage    = "https://github.com/foca/kali"
  spec.files       = `git ls-files`.split("\n")
  spec.platform    = Gem::Platform::RUBY
end
