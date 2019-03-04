require "pry"

class User < ActiveRecord::Base
  has_and_belongs_to_many :releases






end
