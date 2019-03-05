class CommandLineInterface

  def greet
    puts "Welcome to Your Music Database, the command line solution to facilitate your music collecting addiction!"
  end

  def gets_user_input
    puts "\nYou can search and add releases to your music collection"
    puts "\nPlease enter a release title to search the database"
    gets.chomp
  end

  def return_all_artists_and_releases
    Release.all.each {|x| puts "title: #{x.artist} artist: #{x.title} released: #{x.released} genre: #{x.genre} format: #{x.format}" }

    #puts "#{Releases.artists #{Release.titles}"
  end

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

  def initial_options
    puts "Press 1 to search the Discogs API.\nPress 2 to search your own music collection"
  end

  # def search_discogs
  #   puts "Do you have a Discogs account? If so, please input your auth key"
  #   answer = gets.chomp
  #   auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA")
  #
  # end


  # wrapper = Discogs::Wrapper.new("My test app")
  #
  # auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA")
  #
  # test
  # artist = wrapper.get_artist("329937")








  def search_again?
    puts "\nSearch again? input y for yes, and n to return to main menu"
    answer = gets.chomp
    if answer == "y"
      search_local_db
    elsif answer == "n"
      run
    else
      search_again?
    end
  end

  def search_local_db
    puts "Please enter a release title to search the database"
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
      search_discogs
    when "2"
      search_local_db
    else
      "not a valid entry"
      menu
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


  # wrapper = Discogs::Wrapper.new("My test app")
  #
  # auth_wrapper = Discogs::Wrapper.new("My test app", user_token: "tjaSQQrCCwfvkiutVBUXNBLNikYkcwMHVLVEHbcA")
  #
  # test
  # artist = wrapper.get_artist("329937")
