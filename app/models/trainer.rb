class Trainer < ActiveRecord::Base
  has_many :pokemon
  validates :username, :presence => true, :uniqueness => true
end
