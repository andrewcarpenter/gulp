module Gulp
  class Document
    attr_reader :path, :corpus, :word_count, :phrases
  
    def initialize(corpus, attributes)
      @corpus = corpus
      @path = attributes['path']
      @word_count = attributes['word_count'] || 0
      @phrases = attributes['phrases'] || {}
      
      @phrase_extractor = Gulp::PhraseExtractor.new
    end
    
    def self.new_from_file(corpus, path)
      doc = new(corpus, {'path' => path})
      
      text_extractor = XMLTextExtractor.new(doc)
      Nokogiri::XML::SAX::Parser.new(text_extractor).parse(File.open(path))
      doc
    end
    
    def already_processed?
      @corpus.already_processed?(path)
    end
    
    def save!
      @corpus.documents.insert(self.to_mongo)
    end
    
    def to_mongo
      {
        'path' => @path,
        'word_count' => @word_count,
        'phrases' => @phrases
      }
    end
    
    def add_text(text)
      word_count, phrases = @phrase_extractor.extract(text)
      @word_count += word_count
      
      phrases.each do |phrase|
        @phrases[phrase] ||= {'count' => 0}
        @phrases[phrase]['count'] += 1
      end
    end
    
    def number_of_unique_phrases
      phrases.size
    end
    
    def phrases
      phrases.map do |phrase, count|
        Phrase.new(self, phrase, count)
      end
    end
  end
  
  class XMLTextExtractor < Nokogiri::XML::SAX::Document
    def initialize(document)
      super()
      @document = document
    end

    def characters(text)
      @document.add_text(text)
    end
  end
end