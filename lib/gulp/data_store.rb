class Gulp
  class DataStore
    include TokyoCabinet
    include Enumerable
    
    def initialize(path)
      @hdb = HDB::new
      @hdb.open(path + '.hdb', HDB::OWRITER | HDB::OCREAT)
    end
    
    def increment(key)
      @hdb.addint(key,1)
    end
    
    def [](key)
      val = @hdb[key]
      val ? val.unpack('i').first : 0
    end
    
    def []=(key, value)
      @hdb[key] = value
    end
    
    def has_key?(key)
      @hdb[key].present?
    end
    
    def clear!
      @hdb.vanish
    end
    
    def size
      @hdb.rnum
    end
    
    def each_key(&proc)
      @hdb.each_key(&proc)
    end
    def each(&proc)
      @hdb.each(&proc)
    end
  end
end