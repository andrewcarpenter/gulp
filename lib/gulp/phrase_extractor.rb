module Gulp
  class PhraseExtractor
    ALLOWED_PHRASE_LENGTHS = [2,3,4]
    STOPWORDS = %w(a an and except from has in into is made of one that the these this to with)

    def extract(text)
      strings = chunk_text(preprocess_text(text)).map{|s| postprocess_text(s)}.reject{|s| s.blank?}
      phrases = []
      word_count = 0
      strings.each do |string|
        words = string.split(/\s+/)
        word_count += words.size
        
        next if words.size == 0
        
        ALLOWED_PHRASE_LENGTHS.each do |length|
          final_start_position = words.size - length
          (0..final_start_position).each do |start_position|
            sub_phrase_words = words.slice(start_position, length)
            
            next if STOPWORDS.include?(sub_phrase_words.first.downcase) || STOPWORDS.include?(sub_phrase_words.last.downcase)
            
            phrases << sub_phrase_words.join(' ')
          end
        end
      end
      return [word_count, phrases]
    end
    
    private
    def preprocess_text(text)
      # remove parentheticals
      text.gsub!(/\(.+?\)/, ' ')
      text.gsub!(/\[.+?\]/, ' ')
      text.gsub!(/\{.+?\}/, ' ')
      
      text
    end
    
    def postprocess_text(text)
      text.gsub!(/[^ a-zA-Z0-9-]/,'')
      text.gsub!(/^\s+|\s+$/,'')
      text.gsub!(/\s+/, ' ')
      text
    end
    
    def chunk_text(text)
      text.split(/\.|,|:|;|\|/).compact
    end
  end
end