# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "itsumade/version"
 
Gem::Specification.new do |s|
  s.name        = "itsumade"
  s.version     = Dokoe::VERSION::STRING
  s.authors     = ["Bryan McKelvey"]
  s.email       = ["bryan.mckelvey@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/itsumade"
  s.summary     = %q{Ima doko desu ka?}
  s.description = %q{Eki no norikae annai}
   
  s.rubyforge_project = "itsumade"
   
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
