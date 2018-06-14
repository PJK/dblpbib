lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dblpbib/version'

Gem::Specification.new do |spec|
	spec.name          = 'dblpbib'
	spec.version       = Dblpbib::VERSION
	spec.authors       = ['PJK']
	spec.email         = ['me@pavelkalvoda.com']

	spec.summary       = Dblpbib::DESCRIPTION
	spec.description   = 'Automatically create bibliographies for BibTeX DBLP
references. This utility is meant to be invoked during LaTeX build. It scans
the documents for DBLP references and compiles a cached .bib file. Correctly
handles crosslinking. Entries can be overridden. Other bibliography sources
can still be included.'
	spec.homepage      = 'https://github.com/PJK/dblpbib'
	spec.license       = 'MIT'

	spec.files         = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.bindir        = 'exe'
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler', '~> 1.16'
	spec.add_development_dependency 'rake', '~> 10.0'
	spec.add_development_dependency 'rspec', '~> 3'
	spec.add_development_dependency 'rubocop', '~> 0.57'

	spec.add_dependency 'commander'
end
