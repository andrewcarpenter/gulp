# Gulp

Ruby gem for identifying Statistically Improbable Phrases across a large document set.

This is pre-alpha.

## Install

    [sudo] gem install gulp

## Usage

    gulp = Gulp.new(:database_directory => '/path/to/dir')
    
    gulp.add_xml_file_to_corpus('/path/to/file/1')
    gulp.add_xml_file_to_corpus('/path/to/file/2')
    gulp.add_xml_file_to_corpus('/path/to/file/3')
    
    gulp.sips_for('/path/to/file/3') # => [<Gulp::Phrase>, <Gulp::Phrase>]

## Copyright

Copyright (c) 2010 Andrew Carpenter. See LICENSE for details.
