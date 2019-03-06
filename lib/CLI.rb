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
      initial_options
    end
  end

  def search_discogs_api_with_test_account
    auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "HxMncBsZapqMGnwfoDrZZsRvHZevQOzPhZcHmKwC") # AUTH KEY
    puts "\nPress 1 to search the Discogs API by release title. Press 2 to return to the main menu."
    answer = gets.chomp
    if answer == "1"
      discogs_release_title_search
    elsif answer == "2"
      run
    else
      search_discogs_api_with_test_account
    end
  end

  def discogs_release_title_search
    puts "\nPlease enter a release title to Search the Discogs API."
    answer = gets.chomp
    search = auth_wrapper.search(answer, :per_page => 10, :type => :artist)
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
      destroy_local_db_entry
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
    Release.all.each do |releases|
      puts "title: #{releases.artist} artist: #{releases.title} released: #{releases.released} genre: #{releases.genre} format: #{releases.format}"
    end
    puts "\npress r to return to the music collection search menu\n"
    answer = gets.chomp
    if answer == "r"
      system "clear"
      search_local_db_submenu
    else nil
    end
  end

  def search_local_db_by_release_title
    puts "Please enter a release title to search the database"
    title = gets.chomp
    if r = Release.find_by_title(title)
      puts "\n title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
      search_again?
    else
      puts "\nRelease not found"
      search_again?
    end
  end

  def destroy_local_db_entry
    puts "Please input the title of the release you would like to remove from your collection"
    title = gets.chomp
    if Release.find_by_title(title)
      Release.where(title: title).delete_all
      sleep 1
      puts "Release deleted. Returning to main menu"
      sleep 1
    run
    else
      puts "Can not find release with that title in your database"
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
