class Devpurchased < ActiveRecord::Base
  belongs_to :profile
  belongs_to :recruiter
end
