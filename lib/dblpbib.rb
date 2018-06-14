require "dblpbib/version"

module Dblpbib
	def self.scan_keys(document)
		document
			.gsub(/(?<!\\)%.*$/, '')
			.scan(/\\cite(\[[^\]]+\])?\{([^\}]+)\}/)
			.map(&:pop)
			.flat_map { |keyset| keyset.split(',') }
			.map(&:strip)
			.keep_if { |key| key.start_with?('DBLP:') }
			.map { |key| key.sub('DBLP:', '') }
			.uniq
	end
end
