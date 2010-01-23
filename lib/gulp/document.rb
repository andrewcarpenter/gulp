class Gulp
  class Document
    attr_reader :name, :corpus, :word_count, :phrase_counts
  
    def initialize(name, corpus)
      @name = name
      @corpus = corpus
      @word_count = 0
      @finalized = false
      @phrase_counts = {}#Gulp::DataStore.new('document')
      @extractor = Gulp::PhraseExtractor.new
    end
  
    def process!
      extractor = XMLTextExtractor.new(self)
      Nokogiri::XML::SAX::Parser.new(extractor).parse(File.open(name))
      self
    end
    
    def already_processed?
      @corpus.already_processed?(name)
    end
    
    def finalized?
      @finalized
    end
    
    def add_to_corpus!
      unless already_processed?
        @finalized = true
        @phrase_counts.each_key do |phrase|
          @corpus.increment_phrase_document_count(phrase)
        end
    
        @corpus.mark_as_processed!(name)
      end
    end
    
    def add_text(text)
      raise "cannot add text once finalized" if finalized?
      word_count, phrases = @extractor.extract(text)
      
      phrases.each do |phrase|
        @phrase_counts[phrase] ||= 0
        @phrase_counts[phrase] += 1
      end
    end
    
    def number_of_unique_phrases
      phrase_counts.size
    end
    
    def phrases
      phrase_counts.map do |phrase, count|
        Phrase.new(self, phrase, count)
      end
    end
  end
  
  class XMLTextExtractor < Nokogiri::XML::SAX::Document
    def initialize(phrase_extractor)
      super()
      @phrase_extractor = phrase_extractor
    end

    def characters(text)
      @phrase_extractor.add_text(text)
    end
  end
end