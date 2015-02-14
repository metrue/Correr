Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "ctc"
  s.version     = "1.0"
  s.date        = "2015-02-14"
  s.summary     = "typo checking of comments in source code"
  s.description = "ctc, a comments typo checking tool for Ruby, Python, Javascript, Perl, Shell, C/C++"
  s.author      = "Minghe Huang"
  s.email       = "h.mignhe@gmail.com"
  s.files       = Dir["lib/*", "test/*", "README.md", "ctc.gemspec", "ctc"]
  s.homepage    = "http://minghe.me"
  s.license     = "MIT"
end
