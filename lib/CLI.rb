class CommandLineInterface

  def run
    system "clear"
    greet
    initial_options
    menu
  end

  def greet
    puts "Welcome to Your Music Database, the command line solution to facilitate your music collecting addiction!"
  end

  def initial_options
    puts "\nPress 1 to search the Discogs API.\nPress 2 to search and edit your own music collection"
  end

  def menu
    answer = gets.chomp
    case answer
    when "1"
      sleep 1
      system "clear"
      search_discogs_menu
    when "2"
      sleep 1
      system "clear"
      search_local_db_submenu
    else
      "not a valid entry"
      sleep 1
      run
    end
  end

  def search_discogs_menu
    puts "\nDo you have a Discogs account? input y for yes, n for no, or any other key for main menu"
    answer = gets.chomp
    if answer == "y"
      puts "\nPlease input your auth key"
      authkey = gets.chomp
      auth_wrapper = Discogs::Wrapper.new("My test app", user_token: authkey)
      sleep 1
      system "clear"
      search_discogs_api
    elsif answer == "n"
      puts "\nUsing a test account instead"
      sleep 1
      system "clear"
      search_discogs_api_with_test_account
    else
      run
    end
  end

  def search_discogs_api_with_test_account
    puts "\nPress 1 to search the Discogs API by release title. Press 2 to return to the main menu."
    answer = gets.chomp
    system "clear"
    if answer == "1"
      discogs_release_title_search
    elsif answer == "2"
      run
    else
      search_discogs_api_with_test_account
    end
  end

  def discogs_release_title_search
    auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "HxMncBsZapqMGnwfoDrZZsRvHZevQOzPhZcHmKwC") # AUTH KEY

    puts "\nPlease enter the name of the artist whose release you wish to search."

    artist_answer = gets.chomp
    artist_search = auth_wrapper.search(artist_answer, :per_page => 10, :type => :artist)

    prompt = puts "\nDid you mean #{artist_search.results.first.title}? press y for yes or n for no"
    response = gets.chomp

    if response == "y"
      puts "#{artist_search.results.first.profile}"
      sleep 1
      puts "Please enter the name of the release you wish to view."
      release_answer = gets.chomp.titleize
      #artist_releases = auth_wrapper.get_artist_releases(artist_search.results.first.id)
      titles = auth_wrapper.get_artist_releases(artist_search.results.first.id).releases.map {|release_titles| release_titles.title}
      if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
        puts "Release Found"
        release_information = auth_wrapper.get_artist_releases(artist_search.results.first.id).releases.find {|titles| titles.title == release_answer}
        #puts "#{auth_wrapper.get_artist_releases(artist_search.results.first.id).releases.find {|titles| titles.title == release_answer}}" # returns release information
        sleep 1
        puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.first.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"

        puts "Would you like to add this to your collection? y or n?"
        collection_response = gets.chomp
        if "y"
          Release.create(artist: auth_wrapper.get_artist(artist_search.results.first.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
          puts "Added to your music collection. Returning to main menu"
          run
        else
          search_discogs_menu
        end
      else
        puts "Release not found"
        sleep 1
        search_discogs_menu
      end

    elsif response == "n"
      puts "\nDid you mean #{artist_search.results.second.title}? press y for yes or n for no"
      response2 = gets.chomp

      if response2 == "y"
        #puts "\nPlease enter the name of the release you wish to view"
        #puts "#{artist_search.results.second.profile}"
        #puts "This artist has #{artist_releases.releases.count} releases"
        puts "\nPlease enter the name of the release you wish to view."
        release_answer = gets.chomp.titleize
        #artist_releases = auth_wrapper.get_artist_releases(artist_search.results.first.id)
        titles = auth_wrapper.get_artist_releases(artist_search.results.second.id).releases.map {|release_titles| release_titles.title}
        if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
          puts "Release Found"
          release_information = auth_wrapper.get_artist_releases(artist_search.results.second.id).releases.find {|titles| titles.title == release_answer}
          #puts "#{auth_wrapper.get_artist_releases(artist_search.results.first.id).releases.find {|titles| titles.title == release_answer}}" # returns release information
          sleep 1
          puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.second.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"

          puts "Would you like to add this to your collection? y or n?"
          collection_response = gets.chomp
          if "y" || "yes" || "Yes"
            Release.create(artist: auth_wrapper.get_artist(artist_search.results.second.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
            puts "Added to your music collection. Returning to main menu"
            run
          else
            search_discogs_menu
          end
        else
          puts "Release not found"
          sleep 1
          syste "clear"
          search_discogs_menu
        end

    elsif response2 == "n"
        puts "\nDid you mean #{artist_search.results.third.title}? press y for yes or n for no"
        response3 = gets.chomp
        if response3 == "y"
            #puts "\nPlease enter the name of the release you wish to view"
            #puts "#{artist_search.results.second.profile}"
            #puts "This artist has #{artist_releases.releases.count} releases"
            puts "\nPlease enter the name of the release you wish to view."
            release_answer = gets.chomp.titleize
            #artist_releases = auth_wrapper.get_artist_releases(artist_search.results.first.id)
            titles = auth_wrapper.get_artist_releases(artist_search.results.third.id).releases.map {|release_titles| release_titles.title}
            if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
              puts "Release Found"
              release_information = auth_wrapper.get_artist_releases(artist_search.results.third.id).releases.find {|titles| titles.title == release_answer}
              #puts "#{auth_wrapper.get_artist_releases(artist_search.results.first.id).releases.find {|titles| titles.title == release_answer}}" # returns release information
              sleep 1
              puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.third.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"

              puts "Would you like to add this to your collection? y or n?"
              collection_response = gets.chomp
              if "y" || "yes" || "Yes"
                Release.create(artist: auth_wrapper.get_artist(artist_search.results.third.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
                puts "Added to your music collection. Returning to main menu"
                run
              else
                search_discogs_menu
              end
            else
              puts "Release not found"
              sleep 1
              syste "clear"
              search_discogs_menu
            end

        elsif response3 == "n"
          puts "Please search again"
          sleep 1
          system "clear"
          discogs_release_title_search
        else
          nil
        end
      else
        nil
      end
    else
      nil
    end
  end

  def search_local_db_submenu
    puts "Press 1 to search your collection by release title\nPress 2 to list all records in your collection\nPress 3 to remove a release from your collection\nPress m to return to main menu"
    answer = gets.chomp
    if answer == "1"
      sleep 1
      system "clear"
      search_local_db
    elsif answer == "2"
      sleep 1
      system "clear"
      return_all_artists_and_releases
    elsif answer == "3"
      sleep 1
      destroy_local_db_entry
    elsif answer == "m"
      sleep 1
      system "clear"
      run
    else
      sleep 1
      search_local_db_submenu
    end
  end

  def search_local_db
    puts "\nPlease enter a release title to search the database"
    title = gets.chomp.downcase
    if r = Release.find_by_title(title)
      puts "artist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
      search_again?
    else
      puts "Release not found"
      search_again?
    end
  end

  def search_again?
    puts "\nSearch again? input y for yes, and n to return to main menu"
    answer = gets.chomp
    if answer == "y"
      sleep 1
      system "clear"
      search_local_db
    elsif answer == "n"
      sleep 1
      system "clear"
      run
    else
      sleep 1
      search_again?
    end
  end

  def return_all_artists_and_releases
    Release.all.each do |releases|
      puts "artist: #{releases.artist} title: #{releases.title} released: #{releases.released} genre: #{releases.genre} format: #{releases.format}"
    end
    puts "\npress m to return to the music collection search menu\n"
    answer = gets.chomp
    if answer == "m"
      sleep 1
      system "clear"
      search_local_db_submenu
    else
      nil
    end
  end

  def search_local_db_by_release_title
    puts "Please enter a release title to search the database"
    title = gets.chomp.titlize
    if r = Release.find_by_title(title)
      puts "\n artist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
      search_again?
    else
      puts "\nRelease not found"
      search_again?
    end
  end

  def destroy_local_db_entry
    puts "Please input the title of the release you would like to remove from your collection"
    title = gets.chomp.titleize
    if Release.find_by_title(title)
      Release.where(title: title).delete_all
      sleep 1
      puts "\nRelease deleted. Returning to main menu"
      sleep 1
      run
    else
      puts "\nCan not find release with that title in your database"
      sleep 1
      run
    end
  end





end





  # gets.chomp
  # title = gets_user_input
  # if r = Release.find_by_title(title)
  #      puts "title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
  #    else
  #      puts "Release not found"
  #      initial_options
  #      answer = gets.chomp
  #    end
  # else
  # initial_options
  # answer = gets.chomp


  # def do_you_want_to_add_this?(r)
  #   puts "Do you want to add this to your music collection?"
  #   answer = gets.chomp
  #   if answer = "yes"
  #     r.save
  #   else
  #     nil
  #   end
  # end

    # def run
    #   greet
    #   title = gets_user_input
    #   if r = Release.find_by_title(title)
    #     puts "title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
    #   else
    #     puts "Release not found"
    #   end
    #   #do_you_want_to_add_this?(r)
    #   return_all_artists_and_releases
    # end

  # wrapper = Discogs::Wrapper.new("My test app")
  #
  # auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA")
  #
  # test
  # artist = wrapper.get_artist("329937")

  # wrapper = Discogs::Wrapper.new("My test app")
  #
  # auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA")
  #
  # test
  # artist = wrapper.get_artist("329937")

  # def gets_user_input
  #   puts "\nYou can search and add releases to your music collection"
  #   puts "\nPlease enter a release title to search the database"
  #   gets.chomp
  # end

  #puts artist_releases.releases.first.title
  #artist_id = auth_wrapper.get_artist_releases(artist_search.results.first.id).first

  #artist_search.get_artist_releases
  #artist_search.results.first.get_artist_releases
