require "pry"

class User < ActiveRecord::Base
  has_many :users_releases
  has_many :releases, :through => :users_releases

def rate_release(title, rating)
  release = self.releases.find_by_title(title)
  #binding.pry
  user_release = self.users_releases.find {|user_release| user_release.release_id == release.id}
  user_release.rating = rating
  user_release.save
end



end
