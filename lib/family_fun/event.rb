class FamilyFun::Event

    attr_accessor :name, :date, :location, :url, :calendar

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
    
    def self.list_events
        colorizer = Lolize::Colorizer.new
        system "clear"
        puts <<-DOC.gsub /^\s*/, ''

        THURSDAY, JAN. 3
        1. Winter Fishtival
        THURSDAY, JAN. 2 9:30 a.m. - 5:00 p.m.
        Seattle Aquarium 
        Seattle\n
        2. Global Game Jam
        THURSDAY, JAN. 2 10:00 a.m. - 6:00 p.m.
        Pacific Science Center 
        Seattle\n
        It is working!!!!
        DOC

        event = self.new
        event.name = "Winter Fishtival"
        event.date = "THURSDAY, JAN. 2 9:30 a.m. - 5:00 p.m."
        event.location = "Seattle Aquarium"
        event.city = "Seattle"
        event.url = "https://www.parentmap.com/calendar/mommy-matinees-admiral"
    
    end

    def self.free
        system "clear"
        puts <<-DOC.gsub /^\s*/, ''

        FRIDAY, JAN. 3
        
        1. Winter Wonderland at Redmond Town Center
        FRIDAY, JAN. 3 10:00 a.m. - 8:00 p.m.
        Redmond Town Center 
        Redmond
        2. Free First Friday at BAM
        FRIDAY, JAN. 3 11:00 a.m. - 8:00 p.m.
        Bellevue Arts Museum 
        Bellevue

        DOC
    end

    def self.editors
        puts "testing.. testing... testing.."
    end


end
