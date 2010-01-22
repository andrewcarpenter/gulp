require 'rubygems'
require '~/Desktop/phrase_extractor.rb'
require "tokyocabinet"
include TokyoCabinet

global_phase_document_counts = HDB::new
global_phase_document_counts.open("document_counts.hdb", HDB::OWRITER | HDB::OCREAT)

processed_documents = HDB::new
processed_documents.open("processed_documents.hdb", HDB::OWRITER | HDB::OCREAT)

paths.each_with_index do |path, i|
  puts "processing #{i+1} of #{paths.count}"
  if processed_documents[path]
    puts "already processed #{path}..."
  else
    puts "processing #{path}..."
    processed_documents[path] = 1
    
    input = File.open(path)
    document_phrase_counts = PhraseExtractor.new(input).phrase_counts
    puts "    #{document_phrase_counts.keys.size} unique phrases extracted"
  
    if interrupted
      puts "exiting cleanly"
      exit
    end
    
    document_phrase_counts.keys.each do |phrase|
      global_phase_document_counts.addint(phrase,1)
    end
    
    puts "    #{global_phase_document_counts.rnum} phrases seen total"
  end
  
  if interrupted
    puts "exiting cleanly"
    exit
  end
end
