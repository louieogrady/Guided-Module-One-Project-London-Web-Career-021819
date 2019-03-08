class CommandLineInterface

  def find_or_create_by(username)
    # Find or create new user
    @u = User.find_or_create_by(username: username.chomp.strip)
  end

  def run
    system "clear"
    greet
    initial_options
    menu
  end

  def run2
    system "clear"
    initial_options
    menu
  end

  def greet
    system "clear"
    #puts Rainbow("").red
puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts Rainbow("Welcome to Your Music Database, the command line solution for your
                  music collecting needs!").bright.red
    puts "\nPlease enter your username:"
    username = gets.chomp
    find_or_create_by(username)
    sleep 1
    system "clear"
  end

  def return_to_main_menu_greeting
    system "clear"
    puts "Welcome to Your Music Database, the command line solution for your music collecting needs!"
  end

  def initial_options
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
        puts Rainbow("Welcome to Your Music Database, the command line solution for your
                      music collecting needs!").bright.red
    puts "\nPress 1 to search the Discogs API by release title.\n\nPress 2 to search and edit your own music collection.\n\nPress 3 to logout"
  end

  def menu
    answer = gets.chomp
    case answer
    when "1"
      sleep 1
      system "clear"
      discogs_release_title_search
    when "2"
      sleep 1
      system "clear"
      search_local_db_submenu
    when "3"
      sleep 1
      system "clear"
      run
    when '4'
      sleep 1
      system "clear"
      add_genre_to_entry
    else
      "not a valid entry"
      sleep 1
      run2
    end
  end

  # def search_discogs_api
  #   puts "Press 1 to search the Discogs API by release title. \n\nPress 2 to return to the main menu."
  #   answer = gets.chomp
  #   system "clear"
  #   if answer == "1"
  #     sleep 1
  #     discogs_release_title_search
  #   elsif answer == "2"
  #     sleep 1
  #     run2
  #   else
  #     sleep 1
  #     search_discogs_api
  #   end
  # end

  def discogs_release_title_search
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "HxMncBsZapqMGnwfoDrZZsRvHZevQOzPhZcHmKwC") # AUTH KEY

    puts "\nPlease enter the name of the artist whose release you wish to search"

    artist_answer = gets.chomp.strip
    artist_search = auth_wrapper.search(artist_answer, :per_page => 150, :type => :artist)

    prompt = puts "\nDid you mean #{artist_search.results.first.title}? press y for yes or n for no"
    response = gets.chomp.strip

    if response == "y" || response == "yes" || response == "Yes" || response == "Y"
      puts "\nPlease enter the name of the release you wish to add to your collection"
      release_answer = gets.chomp.strip.titleize
      titles = auth_wrapper.get_artist_releases(artist_search.results.first.id, :per_page =>600).releases.map {|release_titles| release_titles.title}
      if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
        puts "Release Found"
        release_information = auth_wrapper.get_artist_releases(artist_search.results.first.id, :per_page =>600 ).releases.find {|titles| titles.title == release_answer}
        sleep 1
        puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.first.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"
        #binding.pry
        puts "\nWould you like to add this to your collection? y or n?"
        collection_response = gets.chomp.strip
        if collection_response == "y"
          rel = Release.find_or_create_by(artist: auth_wrapper.get_artist(artist_search.results.first.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
            @u.releases << rel
            puts "\nAdded to your music collection. Returning to main menu"
            sleep 1
            system "clear"
            run2
        else
          sleep 1
          system "clear"
          discogs_release_title_search
        end
      else
        puts "Release not found. Returning to main menu"
        sleep 1
        system "clear"
        run2
      end

    elsif response == "n" || response == "no" || response == "No" || response == "N"
      puts "Did you mean #{artist_search.results.second.title}? press y for yes or n for no"
      response2 = gets.chomp.strip

      if response2 == "y" || response == "yes" || response == "Yes" || response == "Y"

        puts "\nPlease enter the name of the release you wish to add to your collection"
        release_answer = gets.chomp.strip.titleize
        titles = auth_wrapper.get_artist_releases(artist_search.results.second.id, :per_page =>600).releases.map {|release_titles| release_titles.title}
        if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
          puts "Release Found"
          release_information = auth_wrapper.get_artist_releases(artist_search.results.second.id, :per_page =>600).releases.find {|titles| titles.title == release_answer}
          sleep 1
          puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.second.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"

          puts "\nWould you like to add this to your collection? y or n?"
          collection_response = gets.chomp.strip
          if collection_response == "y" || collection_response == "yes" || collection_response == "Yes" || collection_response == "Y"
            rel = Release.find_or_create_by(artist: auth_wrapper.get_artist(artist_search.results.second.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
              @u.releases << rel
              puts "\nAdded to your music collection. Returning to main menu"
              run2
          else
            discogs_release_title_search
          end
        else
          puts "\nRelease not found. Returning to main menu"
          sleep 1
          system "clear"
          run2
        end

    elsif response2 == "n"
        puts "Did you mean #{artist_search.results.third.title}? press y for yes or n for no"
        response3 = gets.chomp.strip
        if response3 == "y" || response3 == "Yes" || response3 == "yes" || response3 == "Y"

            puts "\nPlease enter the name of the release you wish to add to your collection"
            release_answer = gets.chomp.titleize
            titles = auth_wrapper.get_artist_releases(artist_search.results.third.id, :per_page =>600).releases.map {|release_titles| release_titles.title}
            if titles.find {|titles| titles == release_answer} # checks if the user query matches the release title for that artist.
              puts "Release Found"
              release_information = auth_wrapper.get_artist_releases(artist_search.results.third.id, :per_page =>600).releases.find {|titles| titles.title == release_answer}
              sleep 1
              puts "\nArtist: #{auth_wrapper.get_artist(artist_search.results.third.id).name}\nTitle:  #{release_information.title}\nReleased: #{release_information.year}\nGenre: #{release_information.genre}\nFormat: #{release_information.format}"

              puts "Would you like to add this to your collection? y or n?"
              collection_response = gets.chomp.strip
              if collection_response == "y" || collection_response == "yes" || collection_response == "Yes" || collection_response == "Y"
                rel = Release.find_or_create_by(artist: auth_wrapper.get_artist(artist_search.results.third.id).name, title: release_information.title, released: release_information.year, genre: release_information.genre, format: release_information.format)
                @u.releases << rel
                puts "\nAdded to your music collection. Returning to main menu"
                sleep 1
                system "clear"
                run2
              else
                sleep 1
                system "clear"
                discogs_release_title_search
              end
            else
              puts "\nRelease not found. Returning to main menu"
              sleep 1
              system "clear"
              run2
            end

        elsif response3 == "n"
          puts "No further matches found. Returning to main menu"
          sleep 1
          system "clear"
          run2
        else
          discogs_release_title_search
        end
      else
        discogs_release_title_search
      end
    else
      puts "Please search again."
      sleep 1
      system "clear"
      run2
    end
  end

  def search_local_db_submenu
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPress 1 to search your collection by release title\n\nPress 2 to list all records in your collection\n\nPress 3 to remove a release from your collection\n\nPress 4 to amend the genre for a release\n\nPress 5 to find all releases in your collection by artist name\n\nPress 6 to add a rating to a release in your collection\n\nPress m to return to main menu"
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
      system "clear"
      destroy_local_db_entry
    elsif answer == "4"
      sleep 1
      system "clear"
      change_genre_entry
    elsif answer == "5"
      sleep 1
      system "clear"
      find_releases_by_artist_name
    elsif answer == "6"
      sleep 1
      system "clear"
      rate_releases
    elsif answer == "m"
      sleep 1
      system "clear"
      run2
    else
      sleep 1
      system "clear"
      search_local_db_submenu
    end
  end

  def rate_releases
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPlease enter the name of the release you want to add a rating to."
    title = gets.chomp.strip.titleize
    puts "\nPlease enter a rating between 1 and 5 for the release."
    rating = gets.chomp.strip.titleize
    @u.rate_release(title, rating)
    sleep 1
    release = @u.releases.find_by_title(title)
    user_release = @u.users_releases.find {|user_release| user_release.release_id == release.id}
    if r = Release.find_by_title(title)
      puts "\nartist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}, rating: #{@u.users_releases.find {|user_release| user_release.release_id == release.id}.rating}"
      puts "\nrating added."
      sleep 3
      run2
    else
      puts "\nRelease not found. Returning to main menu"
      sleep 1
      run2
    end

    # puts "\nartist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}, rating: {user_release.rating}"

  end



  def search_local_db
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPlease enter a release title to search the database"
    title = gets.chomp.strip.titleize
    if r = Release.find_by_title(title)
    #  binding.pry
    release = @u.releases.find_by_title(title)
    #binding.pry
    user_release = @u.users_releases.find {|user_release| user_release.release_id == release.id}
    sleep 1
      puts "\nartist: #{r.artist} title: #{r.title} released: #{r.released} genre: #{r.genre} format: #{r.format} rating: #{user_release.rating}"
      search_again?
    else
      puts "\nRelease not found"
      sleep 1
      search_again?
    end
  end

  def search_again?
    puts "\nSearch again? input y for yes, and n to return to main menu"
    answer = gets.chomp
    if answer == "y" || answer == "yes" || answer == "Yes" || answer == "Y"
      sleep 1
      system "clear"
      search_local_db
    elsif answer == "n" || answer == "N" || answer == "No" || answer == "no"
      sleep 1
      system "clear"
      run2
    else
      sleep 1
      search_again?
    end
  end

  def sorted_releases_by_artist_name
    @u.releases.sort_by { |release| release.artist }
  end

  def return_all_artists_and_releases
    # x = @u.releases.sort_by { |release| release.artist }.map(&:title)
    #
    # release = @u.releases.find_by_title(x)
    # user_release = @u.users_releases.find {|user_release| user_release.release_id == release.id}

    sorted_releases_by_artist_name.each  do |releases|
      puts "\nartist: #{releases.artist} title: #{releases.title} released: #{releases.released} genre: #{releases.genre} format: #{releases.format}" #rating: #{user_release.rating}
      #binding.pry
    end
    puts "\n\npress m to return to the music collection search menu\n"
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
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPlease enter a release title to search your database"
    title = gets.chomp.titleize
    if r = @u.releases.where(title)
      puts "\n artist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}\n"
      sleep 1
      search_again?
    else
      puts "\nRelease not found"
      sleep 1
      search_again?
    end
  end

  def change_genre_entry
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPlease enter the release title that you want to change the genre for:"
    title = gets.chomp.titleize
    sleep 1
    if r = @u.releases.find_by_title(title)
      puts "\nartist: #{r.artist}, title: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
      sleep 1
    else
      puts "\nRelease not found. Returning to main menu"
      sleep 1
      run2
    end
      puts "\nPlease input the new genre for this release"
      input = gets.chomp.titleize
      r.genre = input
      r.save
      sleep 1
      puts "\nGenre changed"
      sleep 1
      run2
  end

    def find_releases_by_artist_name
      puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
      puts "\nPlease enter the artist name to see all their releases that are in your collection"
      ar = gets.chomp.titleize
      r = @u.releases
      x = r.select { |item| item.artist == ar }
        if x.map do |x| x.artist == ar
        puts "\nartist: #{x.artist}, title: #{x.title}, released: #{x.released}, genre: #{x.genre}, format: #{x.format}"
      end
        puts "\nPress any key to return to main menu"
        sleep 1
        answer = gets
        run2
      else
        puts "\nThis artist was not found in your collection"
        sleep 1
        puts "Press any key to return to main menu"
        answer = gets
        run2
      end
    end

  def destroy_local_db_entry
    puts Rainbow("
#     #                         #     #
 #   #   ####  #    # #####     ##   ## #    #  ####  #  ####
  # #   #    # #    # #    #    # # # # #    # #      # #    #
   #    #    # #    # #    #    #  #  # #    #  ####  # #
   #    #    # #    # #####     #     # #    #      # # #
   #    #    # #    # #   #     #     # #    # #    # # #    #
   #     ####   ####  #    #    #     #  ####   ####  #  ####

    ######
    #     #   ##   #####   ##   #####    ##    ####  ######
    #     #  #  #    #    #  #  #    #  #  #  #      #
    #     # #    #   #   #    # #####  #    #  ####  #####
    #     # ######   #   ###### #    # ######      # #
    #     # #    #   #   #    # #    # #    # #    # #
    ######  #    #   #   #    # #####  #    #  ####  ###### ").bright.blue
    puts "\nPlease input the title of the release you would like to remove from your collection"
    title = gets.chomp.titleize
    if Release.find_by_title(title)
      Release.where(title: title).delete_all
      sleep 1
      puts "\nRelease deleted. Returning to main menu"
      sleep 1
      run2
    else
      puts "\nCan not find release with that title in your database. Press 1 to try again or press or press m to return to the main menu"
      answer = gets.chomp
      if answer == "1"
        sleep 1
        system "clear"
        destroy_local_db_entry
      elsif answer == "m"
        sleep 1
        system "clear"
        run2
      else
        nil
      end
    end
  end


end

# def compare_collections
#   binding.pry
#   users = User.all
#   releases_for_all_users = users.map {|releases| releases.title releases.released}
#   #puts @u.releases && release_for_all_users if
# end

# def search_discogs_menu
#   puts "\nDo you have a Discogs account? input y for yes, n for no, or any other key for main menu"
#   answer = gets.chomp
#   if answer == "y"
#     puts "\nPlease input your auth key"
#     authkey = gets.chomp
#     auth_wrapper = Discogs::Wrapper.new("My test app", user_token: authkey)
#     sleep 1
#     system "clear"
#     search_discogs_api
#   elsif answer == "n"
#     puts "\nUsing a test account instead"
#     sleep 1
#     system "clear"
#     search_discogs_api
#   else
#     run2
#   end
# end

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
