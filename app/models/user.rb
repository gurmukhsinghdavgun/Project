class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_one :profile
  has_one :github_profile

  after_create :build_profile

  def build_profile
    self.create_profile
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.create_github_profile auth
    user
  end

  def create_github_profile auth
  GithubProfile.create({user_id: id, nickname: auth[:info][:nickname]||"",
    image: auth[:info][:image]||"",
    location: auth[:extra][:raw_info][:location]||"",
    public_repo: auth[:extra][:raw_info][:public_repos]||"",
    public_gists: auth[:extra][:raw_info][:public_gists]||"",
    followers: auth[:extra][:raw_info][:followers]||"",
    following: auth[:extra][:raw_info][:following]||"",
    member_since: auth[:extra][:raw_info][:created_at]||"",
    access_token: auth[:credentials][:token]})
  end

end
