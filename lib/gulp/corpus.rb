class Gulp
  class Corpus
    def initialize(database_directory)
      @database_directory = database_directory
      @processed_documents = HDB::new
      @processed_documents.open("#{@database_directory}/processed_documents.hdb", HDB::OWRITER | HDB::OCREAT)
    end
    
    def already_processed?(document_name)
      @processed_documents[document_name].present?
    end
    
    def mark_as_processed(document_name)
      @processed_documents[document_name] = 1
    end
  end
end