class Gulp
  class Corpus
    
    attr_reader :phrase_document_counts
    def initialize(database_directory)
      @database_directory = database_directory
      @processed_documents = Gulp::DataStore.new("#{@database_directory}/processed_documents")
      @phrase_document_counts = Gulp::DataStore.new("#{@database_directory}/phrase_document_counts")
    end
    
    def mark_as_processed!(document_name)
      @processed_documents.increment(document_name)
    end
    
    def already_processed?(document_name)
      @processed_documents.has_key?(document_name)
    end
    
    def total_number_of_documents
      @processed_documents.size
    end
    
    def number_of_unique_phrases
      @phrase_document_counts.size
    end
    
    def increment_phrase_document_count(phrase)
      @phrase_document_counts.increment(phrase)
    end
    
    def phrase_document_count(phrase)
      @phrase_document_counts[phrase]
    end
  end
end