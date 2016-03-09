class Favorite < ActiveRecord::Base
  belongs_to :recruiter
  belongs_to :favorited, polymorphic: true
end
