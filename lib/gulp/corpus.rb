class Gulp
  class Corpus
    include TokyoCabinet
    
    def initialize(database_directory)
      @database_directory = database_directory
      @processed_documents = HDB::new
      @processed_documents.open("#{@database_directory}/processed_documents.hdb", HDB::OWRITER | HDB::OCREAT)
      @phrase_document_counts = HDB::new
      @phrase_document_counts.open("#{@database_directory}/phase_document_counts.hdb", HDB::OWRITER | HDB::OCREAT)
    end
    
    def mark_as_processed!(document_name)
      @processed_documents[document_name] = 1
    end
    
    def total_number_of_documents
      @processed_documents.rnum
    end
    
    def increment_phrase_document_count(phrase)
      @phrase_document_counts.addint(phrase,1)
    end
    
    def phrase_document_count(phrase)
      phrase_document_count = @phrase_document_counts[phrase]
      phrase_document_count ? phrase_document_count.unpack('i').first : 0
    end
  end
end