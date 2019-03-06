class Release < ActiveRecord::Base
  has_many :users_releases
  has_many :users, :through => :users_releases

end
