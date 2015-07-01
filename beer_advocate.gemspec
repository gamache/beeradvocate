require './lib/beer_advocate/version'

Gem::Specification.new do |s|
  s.name = 'beeradvocate'
  s.version = BeerAdvocate::VERSION
  s.date = BeerAdvocate::VERSION_DATE

  s.summary = 'Fragile, minimal utilities to scrape Beer Advocate'
  s.description = <<-EOT
    The BeerAdvocate gem contains several brittle, lightly-tested methods
    for turning a beer name into its Beer Advocate URL (by scraping Google),
    and turning a Beer Advocate beer page URL into a hash of attributes
    about the beer (by scraping Beer Advocate).  The gem also installs a
    `beer` executable, which returns JSON-formatted beer information for
    the beer named on the command line.
  EOT
  s.homepage = 'https://github.com/gamache/beeradvocate'
  s.authors = ['Pete Gamache']
  s.email = 'pete@gamache.org'

  s.files = Dir['lib/**/*', 'bin/**/*']
  s.executables << 'beer'
  s.license = 'public domain'
  s.has_rdoc = true
  s.require_path = 'lib'

  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency 'nokogiri', '~> 1.6'
  s.add_dependency 'mechanize', '~> 2.7'

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest', '~> 4.7'
end

