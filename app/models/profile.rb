class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :skillsets
  has_many :skills, through: :skillsets
  has_many :educations
  has_many :portfolios
  has_many :works
  has_and_belongs_to_many :expertises
  has_and_belongs_to_many :cities
  has_many :devpurchaseds
  has_many :recruiters, through: :devpurchaseds

  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :portfolios, :allow_destroy => true

  has_attached_file :image, styles: { medium: "300x500>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def all_skills=(names)
    self.skills = names.split("-").map do |name|
      Skill.where(name: name.strip).first_or_create!
    end
  end

  def all_skills
    self.skills.map(&:name).join("-")
  end

  def self.tagged_with(name)
    Skill.find_by_name!(name).profiles
  end

  def shortbio
    bio.length > 100? bio[0..100] + "..." : bio
  end

  is_impressionable

  self.per_page = 8

  def score
   score = 0

   if self.bio.present?
     if self.bio.length < 100
       score += 2
     elsif self.bio.length > 200 && self.bio.length < 299
       score += 4
     elsif self.bio.length > 300
       score += 5
     end
   else
     score = 0
   end

   if self.image.present?
     score += 5
   end

   if self.location.present?
     score += 2
   end

   if self.phone.present?
     score += 2
   end

   if self.TwitterLink.present?
     score += 1
   end

   if self.GithubLink.present?
     score += 2
   end

   if self.StackLink.present?
     score += 2
   end

   if self.DribbbleLink.present?
     score += 3
   end

   if self.MediumLink.present?
     score += 3
   end

   if self.willingToRelocate == true
     score += 5
   end

   if self.workAbroad == true
     score += 5
   end

   if self.portfolios.present?
     score += 5 * self.portfolios.count
   end

   if self.works.present?
     score += 5 * self.works.count
   end

   if self.educations.present?
     score += 5 * self.educations.count
     self.educations.each do |e|
       case e.level
         when "1st"
          score += 15
         when "2.1"
          score += 10
         when "2.2"
          score += 5
         when "3rd"
          score += 1
        end
        case e.degreetype
          when "Bachelor Degree"
            score += 5
          when "Masters Degree"
            score += 10
          when "PhD"
            score += 20
        end
     end
   end

   case self.experiance
     when "1-2 years"
       score += 5
     when "2-3 years"
       score += 10
     when "3-4 years"
       score += 15
     when "5-6 years"
       score += 20
     when "6-7 years"
       score += 25
     when "7+ years"
       score += 30
   end

   score
  end

end
