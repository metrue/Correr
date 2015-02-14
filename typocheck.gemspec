lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "typocheck"
  s.version     = "1.5"
  s.date        = %q{2015-02-14}
  s.summary     = "typo checking of comments in source code"
  s.description = "typocheck, a comments typo checking tool for Ruby, Python, Javascript, Perl, Shell, C/C++"
  s.author      = "Minghe Huang"
  s.email       = "h.mignhe@gmail.com"
  s.files       = Dir["lib/*", "README.md", "typocheck.gemspec", "bin/*", "tools/*"]
  s.require_paths = ['lib']
  s.executables << "typocheck"
  s.homepage    = "http://minghe.me"
  s.license     = "MIT"
end
