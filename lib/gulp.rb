require 'nokogiri'
require 'active_support'
require 'tokyocabinet'

class Gulp
  VERSION = '0.0.1'
  
  def initialize(options)
    @corpus = Corpus.new(options[:database_directory])
  end
  
  def add_to_corpus(name, text)
    doc = Gulp::Document.new(name, @corpus)
    doc.add_text(text)
  end
  
  def add_xml_file_to_corpus(path)
    Gulp::Document.new_from_xml_file(path, @corpus)
  end
end

require "gulp/corpus"
require "gulp/document"
require "gulp/phrase"

