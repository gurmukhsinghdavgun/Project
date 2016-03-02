class Skill < ActiveRecord::Base
  has_many :skillsets
  has_many :profiles, through: :skillsets
end
