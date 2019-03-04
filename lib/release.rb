require "pry"

class Release < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.create
    release = Release.new
  # release = Release.new(artist, title, released, genre, format)
    release.save
    release
  end

end
