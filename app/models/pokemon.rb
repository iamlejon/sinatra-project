class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :attacks
end
