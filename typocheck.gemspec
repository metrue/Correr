Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "typocheck"
  s.version     = "1.1"
  s.date        = %q{2015-02-14}
  s.summary     = "typo checking of comments in source code"
  s.description = "ctc, a comments typo checking tool for Ruby, Python, Javascript, Perl, Shell, C/C++"
  s.author      = "Minghe Huang"
  s.email       = "h.mignhe@gmail.com"
  s.files       = Dir["lib/*", "README.md", "typocheck.gemspec", "bin/*", "tools/*"]
  s.homepage    = "http://minghe.me"
  s.license     = "MIT"
end
