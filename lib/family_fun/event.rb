class FamilyFun::Event

    attr_accessor :name, :date, :location, :url, :price, :age

    @@all = []
    @@details = []

    def initialize
        # save
    end

    def save 
        self.class.all << self
    end

    def self.all 
        @@all
    end

    def self.details
        @@details
    end

    def self.destroy
        self.all.clear
    end

    def self.find_name_by_index
        colorizer = Lolize::Colorizer.new
        puts ("For more event info. Please enter 1-#{self.all.length}: \n\n")
        @name_input = gets.strip.to_i-1
        @@details << @name_input
        colorizer.write("\nYou have selected: #{self.all[@name_input][:name]}\n\n")

        
    end

    def self.find_date_by_index
        colorizer = Lolize::Colorizer.new
        colorizer.write("\nDate: #{self.all[@name_input][:date]}\n")
    end

    def self.find_location_by_index
        colorizer = Lolize::Colorizer.new
        colorizer.write("\nLocation: #{self.all[@name_input][:location]}\n")
    end

    def self.find_url_by_index
        colorizer = Lolize::Colorizer.new
        colorizer.write("\nURL: https://www.parentmap.com" + "#{self.all[@name_input][:url]}\n\n")
    end
    
end
