module Gulp
  class Phrase
    attr_accessor :document, :string, :count
    def initialize(document, string, count)
      @document = document
      @string = string
      @count = count
    end
    
    def words
      words = string.split(/ /)
    end
    
    def phrase_size
      words.size
    end
    
    def term_frequency
      (count * phrase_size) / document.word_count.to_f
    end
    
    def number_of_documents_with_term
      document.corpus.phrase_document_count(string)
    end
    
    def inverse_document_frequency
      Math.log(document.corpus.total_number_of_documents / (1+number_of_documents_with_term))
    end
    
    def score
      term_frequency * inverse_document_frequency
    end
  end
end