class FamilyFun::Event

    attr_accessor :name, :date, :location, :url

    @@all = []
    @@details = []

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
    
    def self.destroy_details
        self.details.clear
    end

    def self.find_name_by_index
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)
        puts ("Please enter 1-#{self.all.length}: \n\n")
        valid = nil
        while !valid
            @name_input = gets.strip.to_i-1
            valid = if (@name_input >= 0) && (@name_input <= FamilyFun::Event.all.length)
                system "clear"
                @@details << @name_input
            else puts "Invalid entry. Please enter 1-#{self.all.length}: ".red.bold
            end
        end
        FamilyFun::CLI.congrats
        colorizer.write("You have selected: #{self.all[@name_input][:name]}\n\n")
        sleep 1
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
