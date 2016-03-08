class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :skillsets
  has_many :skills, through: :skillsets
  has_many :educations
  has_many :portfolios
  has_many :works
  has_and_belongs_to_many :expertises
  has_and_belongs_to_many :cities

  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :portfolios

  has_attached_file :avatar, :styles => {:medium => "300x300>"}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def all_skills=(names)
    self.skills = names.split(",").map do |name|
      Skill.where(name: name.strip).first_or_create!
    end
  end

  def all_skills
    self.skills.map(&:name).join(",")
  end

  def self.tagged_with(name)
    Skill.find_by_name!(name).profiles
  end

end
