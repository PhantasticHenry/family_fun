class FamilyFun::Scraper

    @@all = []

    def self.scrape_events
        FamilyFun::Event.destroy
        colorizer = Lolize::Colorizer.new
        system "clear"
        website = Nokogiri::HTML(open("https://www.parentmap.com/calendar"))
        events = website.css("div.col-content")
        
        events.each.with_index(1) do |event, i|
            prompt = TTY::Prompt.new(active_color: :cyan)
            event_object = FamilyFun::Event.new
            event_object.name = event.css("h3.event-title").text.strip
            event_object.date = event.css("h4.event-date").text.gsub(/\s+/, "")
            event_object.location = event.css("h5.event-location").text.gsub(/\s+/, "")
            event_object.url = event.css("a").attr("href").text.strip
            puts "#{i}. #{event_object.name}"
                    FamilyFun::Event.all << {
                    :name=>event.css("h3.event-title").text.strip,
                    :date=>event.css("h4.event-date").text.gsub(/\s+/, ""),
                    :location=>event.css("h5.event-location").text.gsub(/\s+/, ""),
                    :url=>event.css("a").attr("href").text.strip
                    } 
        end
    end

    def self.free
        colorizer = Lolize::Colorizer.new
        system "clear"
        website = Nokogiri::HTML(open("https://www.parentmap.com/calendar?geolocation-lat=&geolocation-lng=&geolocation_geocoder_google_geocoding_api_state=1&date=now&keys=&geolocation_geocoder_google_geocoding_api=&geolocation=5&field_event_types_value%5Bfree%5D=free"))
        events = website.css("div.col-content")
        
        events.each.with_index(1) do |event, i|
            event_object = FamilyFun::Event.new
            event_object.name = event.css("h3.event-title").text.strip
            event_object.date = event.css("h4.event-date").text.gsub(/\s+/, "")
            event_object.location = event.css("h5.event-location").text.gsub(/\s+/, "")
            event_object.url = event.css("a").attr("href").text.strip
            puts "#{i}. #{event_object.name}"
        end
    end

    def self.editors
        colorizer = Lolize::Colorizer.new
        system "clear"
        website = Nokogiri::HTML(open("https://www.parentmap.com/calendar?geolocation-lat=&geolocation-lng=&geolocation_geocoder_google_geocoding_api_state=1&date=now&keys=&geolocation_geocoder_google_geocoding_api=&geolocation=5&field_event_types_value%5Beditor%5D=editor"))
        events = website.css("div.col-content")
        
        events.each.with_index(1) do |event, i|
            event_object = FamilyFun::Event.new
            event_object.name = event.css("h3.event-title").text.strip
            event_object.date = event.css("h4.event-date").text.gsub(/\s+/, "")
            event_object.location = event.css("h5.event-location").text.gsub(/\s+/, "")
            event_object.url = event.css("a").attr("href").text.strip
            puts "#{i}. #{event_object.name}"
        end
    end

    def self.all
        @@all
    end
end