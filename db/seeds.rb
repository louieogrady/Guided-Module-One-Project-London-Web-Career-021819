# Add seed data here. Seed your database with `rake db:seed`

Release.delete_all   # Delete these when necessary
User.delete_all      # Delete these when necessary

#Movie.create(title: "Wargames", release_date: 1983, director: "John Badham", lead: "Matthew Broderick", in_theaters: false)

# use CREATE HERE instead of save 

r1 = Release.new(artist: "Metallica", title: "Ride The Lightning", released: 1984, genre: "Thrash Metal", format: "Vinyl")
r1.save
r2 = Release.new(artist: "Edward Flex", title: "Do You Believe In Hawaii?", released: 2009, genre: "Vaporwave", format: "CDr")
r2.save




# hotline_bling = Song.create(:name=>'Hotline Bling')
# thriller = Song.create(:name=>'Thriller')
#
# drake = Artist.create(:name=>'Drake')
# mj = Artist.create(:name=>'Michael Jackson')
#
# rap = Genre.create(:name=>'Rap')
# pop = Genre.create(:name=>'Pop')
#
# hotline_bling.artist = drake
# thriller.artist = mj
#
# drake.songs << hotline_bling
# mj.songs << thriller
#
# pop.songs << thriller
# rap.songs << hotline_bling
