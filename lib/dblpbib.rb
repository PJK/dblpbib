require 'dblpbib/version'

# Bits of logic
module Dblpbib
	def self.scan_keys(document)
		# TODO: Extract the allowed command names, possible make them configurable
		document
			.gsub(/(?<!\\)%.*$/, '')
			.scan(/\\(text|auto)?cite(|(al)?[pt]\*?|year(par|\*)?|par\*?|author\*?|text|)(\[[^\]]+\])?\{([^\}]+)\}/)
			.map(&:pop)
			.flat_map { |keyset| keyset.split(',') }
			.map(&:strip)
			.keep_if { |key| key.start_with?('DBLP:') }
			.map { |key| key.sub('DBLP:', '') }
			.uniq
	end
end
