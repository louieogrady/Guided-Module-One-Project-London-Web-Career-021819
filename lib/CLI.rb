class CommandLineInterface

  def greet
    puts "Welcome to Your Music Database, the command line solution to facilitate your music collecting addiction!"
  end

  def initial_options
    puts "\nPress 1 to search the Discogs API.\nPress 2 to search your own music collection"
  end

  def search_discogs_menu
    puts "\nDo you have a Discogs account? input y for yes, n for no, or any other key for main menu"
    answer = gets.chomp
    if answer == "y"
      puts "\nPlease input your auth key"
      authkey = gets.chomp
      auth_wrapper = Discogs::Wrapper.new("My test app", user_token: authkey)
    elsif answer == "n"
      puts "\nUsing a test account instead"
      auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA") # CHANGE THIS TO NEW ACCOUNT AUTH KEY
    else
      initial_options
    end
  end

  def search_local_db_submenu
    puts "Press 1 to search your collection by release title\nPress 2 to list all records in your collection\nPress m to return to main menu"
    answer = gets.chomp
    if answer == "1"
      sleep 1
      system "clear"
      search_local_db
    elsif answer == "2"
      sleep 1
      system "clear"
      return_all_artists_and_releases
    elsif answer == "m"
      sleep 1
      system "clear"
      run
    else
      search_local_db_submenu
    end
  end

  def search_local_db
    puts "\nPlease enter a release title to search the database"
    title = gets.chomp
    if r = Release.find_by_title(title)
      puts "title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
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
    Release.all.each {|releases| puts "title: #{releases.artist} artist: #{releases.title} released: #{releases.released} genre: #{releases.genre} format: #{releases.format}" }
    puts "\npress r to return to the music collection search menu\n"
    answer = gets.chomp
    if answer == "r"
      system "clear"
      search_local_db_submenu
    else nil
    end
  end

  def search_local_db_by_release_title
    puts "\nPlease enter a release title to search the database"
    title = gets.chomp
    if r = Release.find_by_title(title)
      puts "title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
      search_again?
    else
      puts "Release not found"
      search_again?
    end
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
      run
    end
  end

  def run
    greet
    initial_options
    menu
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
