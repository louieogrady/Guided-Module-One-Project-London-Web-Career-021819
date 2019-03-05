class CommandLineInterface

  prompt = TTY::Prompt.new

  def greet
    puts "Welcome to Your Music Database, the command line solution that facilitates your music collecting addiction!"
  end

  def gets_user_input
    puts "\nYou can search and add releases to your music collection"
    puts "\nPlease enter a release title to search the database"
    gets.chomp
  end

  def return_all_artists_and_releases
    Release.all.each {|x| puts "#{x.artist} - #{x.title}" }
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

  def run
    greet
    title = gets_user_input
    if r = Release.find_by_title(title)
      puts "title: #{r.artist}, artist: #{r.title}, released: #{r.released}, genre: #{r.genre}, format: #{r.format}"
    else
      puts "No release found"
    end
    #do_you_want_to_add_this?(r)
    return_all_artists_and_releases
  end

end





# The find lines method takes in an instance of station and returns that station's lines. How can we
# pass the station that we found in find_station as the argument in find_lines? How about in our run method!

# Lets set the return value of find_station to a variable and pass that variable to the find_lines method.

# Finally, let's output those lines to our users! Create a method that iterates over lines and
# outputs the line name to the console!

#
# def show_lines(lines)
#
# lines.each do |line|

#how could we output each line's name here?
