class Recruiter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites
  has_many :favorite_profiles, through: :favorites, source: :favorited, source_type: 'Profile'

  has_many :devpurchaseds
  has_many :profiles, through: :devpurchaseds

  def self.similar_profiles
      title_keywords = Profile.whatAmI.split(' ')
      Profile.all.sort do |profile1, profile2|
      profile1_title_intersection = profile1.bio.split(' ') & title_keywords
      profile2_title_intersection = profile2.bio.split(' ') & title_keywords
      profile2_title_intersection.length <=> profile1_title_intersection.length
    end
   end

end
