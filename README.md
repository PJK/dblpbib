# DBLPBib

Automatically create bibliographies for BibTeX DBLP references. Pretty much like [this](https://github.com/grundprinzip/dblp), but actually works and is as sane as LaTeX permits.

This utility enables me (and possibly you, no promises) to use DBLP references (e.g. `\cite{DBLP:books/sp/Gratzer16}`) without having to download the BibTeX entries. Just use them as usual and run `dblpbib p_np_proof.tex`, `dblp.bib` will be created in the directory.

## Installation

    $ gem install dblpbib

## Usage

    $ dblpbib -h

## `latexmk` integration

Stick this in your `.latexmkrc`:

```perl
$pdflatex = "dblpbib %S && pdflatex -synctex=1 -halt-on-error %O %S";
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PJK/dblpbib.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

