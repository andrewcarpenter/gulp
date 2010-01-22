require 'rubygems'
require 'activesupport'
require '~/Desktop/phrase_extractor.rb'
require 'tokyocabinet'
include TokyoCabinet

global_phase_document_counts = HDB::new
global_phase_document_counts.open("document_counts.hdb", HDB::OWRITER | HDB::OCREAT)

processed_documents = HDB::new
processed_documents.open("processed_documents.hdb", HDB::OWRITER | HDB::OCREAT)

path = 'data/xml/E71/202/3.xml'
input = File.open(path)
pe = PhraseExtractor.new(input)
document_phrase_counts = pe.phrase_counts


total_number_of_documents = processed_documents.rnum
puts "total documents: #{total_number_of_documents}"
phrases = []
document_phrase_counts.each_pair do |phrase, count|
  words = phrase.split(/ /)
  
  phrase_size = words.size
  
  term_frequency = (count * phrase_size) / pe.total_word_count.to_f
  
  number_of_documents_with_term = global_phase_document_counts[phrase]
  number_of_documents_with_term = number_of_documents_with_term ? number_of_documents_with_term.unpack('i').first : 0
  
  inverse_document_frequency = Math.log(total_number_of_documents / (1+number_of_documents_with_term))
  
  phrases << {
    :phrase => phrase,
    :score => term_frequency * inverse_document_frequency,
    :term_frequency => term_frequency, 
    :inverse_document_frequency => inverse_document_frequency,
    :count => count
  }
end

phrases.sort_by{|a| a[:score]}.each do |p|
  puts "#{p[:phrase]}\t\t=> #{p[:score]} #{p[:count]}"
end