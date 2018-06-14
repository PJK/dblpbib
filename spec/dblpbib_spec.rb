require 'spec_helper'

describe Dblpbib do
	it 'has a version number' do
		expect(Dblpbib::VERSION).not_to be nil
	end

	describe 'scan_keys' do
		it 'extracts keys from cite' do
			expect(
				Dblpbib.scan_keys('\cite{DBLP:journals/jsc/CoppersmithW90}')
			).to contain_exactly('journals/jsc/CoppersmithW90')
		end

		it 'extracts multiple keys' do
			expect(
				Dblpbib.scan_keys(
					'\cite{DBLP:journals/jsc/CoppersmithW90}' \
					'any content in here' \
					'\cite{DBLP:conf/approx/EdelmanHNO11}'
				)
			).to contain_exactly(
				'journals/jsc/CoppersmithW90',
				'conf/approx/EdelmanHNO11'
			)
		end

		it 'does not extract duplicates' do
			expect(
				Dblpbib.scan_keys(
					'\cite{DBLP:journals/jsc/CoppersmithW90} ' \
 					'\cite{DBLP:journals/jsc/CoppersmithW90}'
				)
			).to contain_exactly('journals/jsc/CoppersmithW90')
		end

		it 'does not extract non-DBLP keys' do
			expect(
				Dblpbib.scan_keys(
					'\cite{DBLP:journals/jsc/CoppersmithW90} \cite{mypnpproof}'
				)
			).to contain_exactly('journals/jsc/CoppersmithW90')
		end

		it 'ignores comments' do
			expect(
				Dblpbib.scan_keys('% \cite{DBLP:journals/jsc/CoppersmithW90}')
			).to be_empty
		end

		it 'does not get confused by similar commands' do
			expect(
				Dblpbib.scan_keys('\citefoo{DBLP:journals/jsc/CoppersmithW90}')
			).to be_empty
		end

		describe 'given multiple keys within in the same \\cite' do
			it 'extracts all of them' do
				expect(
					Dblpbib.scan_keys(
						'\cite{DBLP:journals/jsc/CoppersmithW90, ' \
 						'DBLP:conf/approx/EdelmanHNO11}'
					)
				).to contain_exactly(
					'journals/jsc/CoppersmithW90',
					'conf/approx/EdelmanHNO11'
				)
			end

			it 'does not extract non-DBLP keys' do
				expect(
					Dblpbib.scan_keys('\cite{mypnpproof, DBLP:conf/approx/EdelmanHNO11}')
				).to contain_exactly('conf/approx/EdelmanHNO11')
			end

			it 'does not extract duplicates' do
				expect(
					Dblpbib.scan_keys(
						'\cite{DBLP:journals/jsc/CoppersmithW90, ' \
 						'DBLP:journals/jsc/CoppersmithW90}'
					)
				).to contain_exactly('journals/jsc/CoppersmithW90')
			end
		end

		describe 'related commands' do
			[
				'cite',
				'autocite',
				'citet',
				'citet*',
				'citep',
				'citep*',
				'citeauthor',
				'citeauthor*',
				'citeyear',
				'citeyear*',
				'citeyearpar',
				'citealt',
				'citealp',
				'citetext'
			].each do |command|
				it "recognizes #{command}" do
					expect(
						Dblpbib.scan_keys("\\#{command}{DBLP:journals/jsc/CoppersmithW90}")
					).to contain_exactly('journals/jsc/CoppersmithW90')
				end

				it "recognizes #{command} with options" do
					expect(
						Dblpbib.scan_keys(
							"\\#{command}[tricky=#{command},more=5]" \
							  '{DBLP:journals/jsc/CoppersmithW90}'
						)
					).to contain_exactly('journals/jsc/CoppersmithW90')
				end
			end
		end
	end
end
