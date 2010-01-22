require 'nokogiri'
require 'active_support'
require 'tokyocabinet'

class Gulp
  VERSION = '0.0.1'
  
  attr_reader :corpus
  def initialize(options)
    @corpus = Corpus.new(options[:database_directory])
  end
  
  def new_from_xml_file(path)
    Gulp::Document.new_from_xml_file(path, @corpus)
  end
end

require "gulp/corpus"
require "gulp/data_store"
require "gulp/document"
require "gulp/phrase"

