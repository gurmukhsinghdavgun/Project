class Recruiter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites
  has_many :favorite_profiles, through: :favorites, source: :favorited, source_type: 'Profile'

  has_many :devpurchaseds
  has_many :profiles, through: :devpurchaseds

end
