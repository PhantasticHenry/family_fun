class FamilyFun::Event

    attr_accessor :name, :date, :location, :url

    @@all = []

    def initialize
        save
    end

    def save 
        self.class.all << self
    end

    def self.all 
        @@all
    end
    
end
