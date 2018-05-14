module DataFaker
  class DFRandom
    @@random = ::Random.new
    
    def self.rand(arg)
      @@random.rand(arg)
    end
    
    def self.rand_from_zero(arg)
      rand(arg)
    end
    
    def self.rand_from_one(arg)
      rand(arg)+1
    end
    
    def self.rand_tax_multiple
      rand_from_one(0.1).round(2)
    end
    
    def self.rand_msrp_multiple
      (rand_from_zero(0.8)+0.5).round(2)
    end
    
  end
end