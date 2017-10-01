class Trainer < ActiveRecord::Base
  has_many :pokemon
  validates :username, :presence => true, :uniqueness => true
  has_secure_password


  def slug
      username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
      Trainer.all.find{|trainer| trainer.slug == slug}
    end

  end
