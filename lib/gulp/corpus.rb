module Gulp
  class Corpus
    attr_reader :documents
    def initialize()
      @db = Mongo::Connection.new.db("gulp")
      @documents = @db['documents']
      @documents.create_index(:path, :unique => true)
    end
    
    def find_or_build_document(path)
      doc_attributes = @documents.find("path" => path).first
      
      if doc_attributes
        Gulp::Document.new(self, doc_attributes)
      else
        Gulp::Document.new_from_file(self, path)
      end
    end
    
    def total_number_of_documents
      @processed_documents.size
    end
  end
end