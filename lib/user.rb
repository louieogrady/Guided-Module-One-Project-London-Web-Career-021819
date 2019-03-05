require "pry"

class User < ActiveRecord::Base
  has_many :users_releases
  has_many :releases, :through => :users_releases





end
