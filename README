= Gulp

Ruby gem for identifying Statistically Improbable Phrases across a large document set.

== Install

  gem install gulp

== Usage

  gulp = Gulp.new(:database_directory => '/path/to/dir')
  
  gulp.add_xml_file_to_corpus('/path/to/file/1')
  gulp.add_xml_file_to_corpus('/path/to/file/2')
  gulp.add_xml_file_to_corpus('/path/to/file/3')

  gulp.sips_for('/path/to/file/3') # => [<Gulp::Phrase>, <Gulp::Phrase>]
== License

MIT License