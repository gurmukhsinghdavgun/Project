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

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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

  def shortbio
    bio.length > 100? bio[0..100] + "..." : bio
  end

  is_impressionable

  before_save :assign_score

  self.per_page = 8

  def assign_score
    score = self.score || 0
    score += 3 if self.changes.include?(:bio) and self.bio.present?
    self.score = score
  end

end
