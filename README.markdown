# Gulp

Ruby gem for identifying Statistically Improbable Phrases across a large document set.

This is pre-alpha.

## Install

    [sudo] gem install gulp

## Usage

    gulp = Gulp.new(:database_directory => '/path/to/dir')
    
    gulp.new_from_xml_file(path_1).process!
    gulp.new_from_xml_file(path_2).process!
    gulp.new_from_xml_file(path_3).process!
    
    doc = gulp.new_from_xml_file(path_4).process!
    doc.process!
    doc.phrases # => [<Gulp::Phrase>, <Gulp::Phrase>]

## Copyright

Copyright (c) 2010 Andrew Carpenter. See LICENSE for details.
