class FamilyFun::CLI

    @@user_name = []
    
    def call
        welcome
        menu
    end

    def self.user_name
        @@user_name
    end

    def welcome
        system "clear"
        colorizer = Lolize::Colorizer.new
        colorizer.write <<-EOF  



           FFFFFFFFFFFFFFFFFFFFFF                                         iiii   lllllll                              FFFFFFFFFFFFFFFFFFFFFF                                 
           F::::::::::::::::::::F                                        i::::i  l:::::l                              F::::::::::::::::::::F                                  
           F::::::::::::::::::::F                                         iiii   l:::::l                              F::::::::::::::::::::F                                  
           FF::::::FFFFFFFFF::::F                                                l:::::l                              FF::::::FFFFFFFFF::::F                                  
            F:::::F       FFFFFFaaaaaaaaaaaaa      mmmmmmm    mmmmmmm   iiiiiii  l::::lyyyyyyy           yyyyyyy       F:::::F       FFFFFFuuuuuu    uuuuuunnnn  nnnnnnnn    
            F:::::F             a::::::::::::a   mm:::::::m  m:::::::mm i:::::i  l::::l y:::::y         y:::::y        F:::::F             u::::u    u::::un:::nn::::::::nn  
            F::::::FFFFFFFFFF   aaaaaaaaa:::::a m::::::::::mm::::::::::m i::::i  l::::l  y:::::y       y:::::y         F::::::FFFFFFFFFF   u::::u    u::::un::::::::::::::nn 
            F:::::::::::::::F            a::::a m::::::::::::::::::::::m i::::i  l::::l   y:::::y     y:::::y          F:::::::::::::::F   u::::u    u::::unn:::::::::::::::n
            F:::::::::::::::F     aaaaaaa:::::a m:::::mmm::::::mmm:::::m i::::i  l::::l    y:::::y   y:::::y           F:::::::::::::::F   u::::u    u::::u  n:::::nnnn:::::n
            F::::::FFFFFFFFFF   aa::::::::::::a m::::m   m::::m   m::::m i::::i  l::::l     y:::::y y:::::y            F::::::FFFFFFFFFF   u::::u    u::::u  n::::n    n::::n
            F:::::F            a::::aaaa::::::a m::::m   m::::m   m::::m i::::i  l::::l      y:::::y:::::y             F:::::F             u::::u    u::::u  n::::n    n::::n
            F:::::F           a::::a    a:::::a m::::m   m::::m   m::::m i::::i  l::::l       y:::::::::y              F:::::F             u:::::uuuu:::::u  n::::n    n::::n
          FF:::::::FF         a::::a    a:::::a m::::m   m::::m   m::::mi::::::il::::::l       y:::::::y             FF:::::::FF           u:::::::::::::::uun::::n    n::::n
          F::::::::FF         a:::::aaaa::::::a m::::m   m::::m   m::::mi::::::il::::::l        y:::::y              F::::::::FF            u:::::::::::::::un::::n    n::::n
          F::::::::FF          a::::::::::aa:::am::::m   m::::m   m::::mi::::::il::::::l       y:::::y               F::::::::FF             uu::::::::uu:::un::::n    n::::n
          FFFFFFFFFFF           aaaaaaaaaa  aaaammmmmm   mmmmmm   mmmmmmiiiiiiiillllllll      y:::::y                FFFFFFFFFFF               uuuuuuuu  uuuunnnnnn    nnnnnn
                                                                                            y:::::y                                                                         
                                                                                           y:::::y                                                                          
                                                                                          y:::::y                                                                           
                                                                                        y:::::y                                                                            
                                                                                       yyyyyyy  


                    EOF
        puts ''
        puts ''
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        sleep 1.2
        pid = fork{ exec "killall afplay" }
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer.write("\nWhat is your name?  ")
        sleep 1
        @@user_name << user_name = gets.strip
        sleep 1
        colorizer.write " \n------------------------------------------------------"
        colorizer.write "| Hello #{user_name}! Are you ready for some family fun? 🥳   |"
        colorizer.write " ------------------------------------------------------\n"
        sleep 0.5
        if prompt.yes?("\nWould you like see the menu?\n".blue)
        else goodbye
    end

    colorizer.write("\n-----------------------------------------------------------")
    colorizer.write("|   Choose what you would like to do next?   |")
    colorizer.write("----------------------------------------------------------")
    end

    def play_music
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        menu
    end

    def menu
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)

            @menu = [
                {"All events" => -> do list_events end},
                {"Free events" => -> do free_events end},
                {"Editor's choice" => -> do editors_choice end},
                {"Exit" => -> do goodbye end}
            ]
     
            case prompt.select("", @menu)
            when 'All events'
                list_events
            when 'Exit'
                goodbye
            when "Editor's choice"
                editors_choice
            when 'Free events'
                free_events
            end
    end

    def menu2 
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)
        @menu2 = [
            'Event details',
            'Go back',
            'Exit'
        ]
       
        case prompt.select("Select from list of options.", @menu2)
        when 'Event details'
            FamilyFun::Event.find_date_by_index
            FamilyFun::Event.find_location_by_index
            FamilyFun::Event.find_url_by_index
            event_info
        when 'Go back'
            menu
        when 'Exit'
            goodbye
        end
    end

    def event_info
        FamilyFun::Scraper.scrape_details
    end

    def self.congrats
        colorizer = Lolize::Colorizer.new
        colorizer.write <<-DOC


        
            *    *
            *         '       *       .  *   '     .           * *
                                                                        '
                *                *'          *          *        '
            .           *               |               /
                        '.         |    |      '       |   '     *
                        \\*        \\   \\             /
                '          \     '* |    |  *        |*                *  *
                    *      `.       \\   |     *     /    *      '
        .                  \\      |   \\          /               *
            *'  *     '      \\      \\   '.       |
                -._            `                  /         *
        ' '      ``._   *                           '          .      '
            *           *\\*          * .   .      *
        *  '        *    `-._                       .         _..:='        *
                    .  '      *       *    *   .       _.:--'
                *           .     .     *         .-'         *
            .               '             . '   *           *         .
        *       ___.-=--..-._     *                '               '
                                        *       *
                        *        _.'  .'       `.        '  *             *
            *              *_.-'   .'            `.               *
                            .'                       `._             *  '
            '       '                        .       .  `.     .
                .                      *                  `
                        *        '             '                          .
            .                          *        .           *  *
                    *        .                                    '


            DOC
            sleep 1
            colorizer.write ("\tExcellent choice #{FamilyFun::CLI.user_name[0]}!\n\n")
            sleep 1
    end

    def list_events
        colorizer = Lolize::Colorizer.new
        @events = FamilyFun::Scraper.scrape_events
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer.write("\n-----------------------------------------------------")
        puts ("\n\nInterested?\n\n")
        colorizer.write("-----------------------------------------------------\n\n")
        FamilyFun::Event.find_name_by_index
        menu2
        menu
    end

    def free_events
        colorizer = Lolize::Colorizer.new
        @free_events = FamilyFun::Scraper.free
        colorizer.write("\n-----------------------------------------------------")
        puts ("\n\nInterested?\n\n")
        colorizer.write("-----------------------------------------------------\n\n")
        FamilyFun::Event.find_name_by_index
        menu2
        menu
    end

    def editors_choice
        colorizer = Lolize::Colorizer.new
        @editors_choice = FamilyFun::Scraper.editors
        colorizer.write("\n-----------------------------------------------------")
        puts ("\n\nInterested?\n\n")
        colorizer.write("-----------------------------------------------------\n\n")
        FamilyFun::Event.find_name_by_index
        menu2
        menu
    end

    def goodbye
        system "clear"
        colorizer = Lolize::Colorizer.new
        pid = fork{ exec "killall afplay" }
        sleep 0.5
        colorizer.write <<-DOC

        ooooo   ooooo                                                                                          .o8             .o8                        .o. 
        `888'   `888'                                                                                         "888            "888                        888 
         888     888   .oooo.   oooo    ooo  .ooooo.        .oooo.         .oooooooo  .ooooo.   .ooooo.   .oooo888        .oooo888   .oooo.   oooo    ooo 888 
         888ooooo888  `P  )88b   `88.  .8'  d88' `88b      `P  )88b       888' `88b  d88' `88b d88' `88b d88' `888       d88' `888  `P  )88b   `88.  .8'  Y8P 
         888     888   .oP"888    `88..8'   888ooo888       .oP"888       888   888  888   888 888   888 888   888       888   888   .oP"888    `88..8'   `8' 
         888     888  d8(  888     `888'    888    .o      d8(  888       `88bod8P'  888   888 888   888 888   888       888   888  d8(  888     `888'    .o. 
        o888o   o888o `Y888""8o     `8'     `Y8bod8P'      `Y888""8o      `8oooooo.  `Y8bod8P' `Y8bod8P' `Y8bod88P"      `Y8bod88P" `Y888""8o     .8'     Y8P 
                                                                          d"     YD                                                           .o..P'          
                                                                          "Y88888P'                                                           `Y8P'
        DOC
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        sleep 5
        pid = fork{ exec "killall afplay" }
        exit
    end

    def stop_music
        pid = fork{ exec "killall afplay" }
    end

end