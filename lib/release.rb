require "pry"

class Release < ActiveRecord::Base
  has_many :users_releases
  has_many :users, :through => :users_releases

  # def self.create
  #   release = Release.new
  #   release = Release.new(artist, title, released, genre, format)
  #   release.save
  #   release
  # end

end
