class FamilyFun::CLI
    
    def call
        welcome
        menu
        list_events
        goodbye
    end

    def welcome
        system "clear"
        colorizer = Lolize::Colorizer.new
        colorizer.write <<-DOC                                                                                                                                                               
        FFFFFFFFFFFFFFFFFFFFFF                                          iiii  lllllll                              FFFFFFFFFFFFFFFFFFFFFF                                 
        F::::::::::::::::::::F                                         i::::i l:::::l                              F::::::::::::::::::::F                                  
        F::::::::::::::::::::F                                          iiii  l:::::l                              F::::::::::::::::::::F                                  
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
                DOC
        puts ''
        puts ''

        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        colorizer.write "What is your name?  "
        sleep 0.5
        input = gets.strip
        colorizer.write " ------------------------------------------------------"
        colorizer.write "| Hello #{input}! Are you ready for some family fun? 🥳   |"
        colorizer.write " ------------------------------------------------------\n"
        sleep 0.5
    end

    def play_music
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
    end

    def menu
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)
        prompt.yes?('Would you like see the menu?'.blue)
        colorizer.write('----------------------------------------------------------')
        colorizer.write("|  Choose what you would like to do next?  |")
        colorizer.write('----------------------------------------------------------')
        while prompt.select("", @menu) != 'Exit'
            @menu = [
                {"All events" => -> do list_events end},
                {"Free events" => -> do free_events end},
                {"Editor's choice" => -> do editors_choice end},
                {"Stop music" => -> do stop_music end},
                {"Play music" => -> do play_music end},
                {"Exit" => -> do goodbye end}
            ]
     
            case prompt.select("", @menu)
            when 'All events'
                list_events
            when 'Stop music'
                stop_music
            when 'Play music'
                play_music
            when 'Exit'
                goodbye
            when "Editor's choice"
                editors_choice
            when 'Free events'
                free_events
            end
        end
    end

    def list_events
        @all_events = FamilyFun::Event.list_events
    end

    def free_events
        @all_events = FamilyFun::Event.free
    end

    def editors_choice
        @all_events = FamilyFun::Event.editors
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