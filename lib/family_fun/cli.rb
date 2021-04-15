class FamilyFun::CLI
    def call
        FamilyFun::Scraper.scrape_events
        welcome
        menu
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
        puts "\n\n"
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer.write("\nWhat is your name?  ")
        sleep 1
        @user_name = gets.strip
        sleep 1

        colorizer.write "\n\n Hello #{@user_name}! Are you ready for some family fun? 🥳   \n\n"
        colorizer.write("-"*70)
        puts ""
        colorizer.write("-"*70)
        sleep 0.5
        if prompt.yes?("\n\nWould you like see the menu?\n\n".blue)
        else goodbye
        end
        colorizer.write("-"*70)
        puts ""
        colorizer.write("-"*70)
        colorizer.write("\n\n      What you would like to do next?      \n\n")
        colorizer.write("-"*70)
        puts ""
        colorizer.write("-"*70)
    end

    def menu
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)

            menu = [
                {"All events" => -> do list_all_events end},
                {"Free events" => -> do free_events end},
                {"Exit" => -> do goodbye end}
            ]
     
            prompt.select("", menu)
    end

    def event_details(details)
        FamilyFun::Event.all.detect do |e| 
            e.details == details
        end
    end

    def display(event)
        colorizer = Lolize::Colorizer.new
        congrats
        if event.price == nil 
            colorizer.write("\n\nDetails:\n\n#{event.details}\n\nPrice: Free!#{event.price}\n\nDate: #{event.date}\n\nLocation: #{event.location}\n\nAddress: #{event.address}\n\nURL: #{event.url}\n\n")
        else
            colorizer.write("\n\nDetails:\n\n#{event.details}\n\nPrice: #{event.price}\n\nDate: #{event.date}\n\nLocation: #{event.location}\n\nAddress: #{event.address}\n\nURL: #{event.url}\n\n")
        end
    end
    def list_all_events
        system "clear"
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)
        events = []
        colorizer.write("\n\n"+("-"*75)+"\n\n")
        colorizer.write("All Events")
        FamilyFun::Event.all.each do |event|
            events << {event.name => -> do display(event) end}
        end
        colorizer.write("\n\n"+("-"*75)+"\n\n")
        prompt.select("Choose an event", events, per_page: FamilyFun::Event.all.count)
        menu2
    end

    def free_events
        system "clear"
        colorizer = Lolize::Colorizer.new
        free = []
        FamilyFun::Event.all.each do |e|
            if e.price == nil
                free << e
            end
        end
        
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer = Lolize::Colorizer.new
        events = []
        colorizer.write("\n\n"+("-"*75)+"\n\n")
        colorizer.write("Free Events")
        FamilyFun::Event.all.each do |event| 
            events << {event.name => -> do display(event) end}
        end
        colorizer.write("\n\n"+("-"*75)+"\n\n")
        prompt.select("Choose an event", events, per_page: free.count)
        menu2
    end

    def congrats
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
            colorizer.write ("\tExcellent choice #{@user_name}!\n\n")
            sleep 1
    end

    def menu2
        prompt = TTY::Prompt.new(active_color: :cyan)
        puts "\n"
        menu2 = [
            'Back to menu',
            'Exit'
        ]
       
        case prompt.select("Select from list of options.", menu2)
        when 'Back to menu'
            menu
        when 'Exit'
            goodbye
        end
    end

    def goodbye
        system "clear"
        colorizer = Lolize::Colorizer.new
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
        exit
    end
end