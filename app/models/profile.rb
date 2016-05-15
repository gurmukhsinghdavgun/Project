class Profile < ActiveRecord::Base
  require 'csv'
  cattr_accessor :crepos

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

  def words
    scan(/\w[\w\'\-]*/)
  end

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

  #def shortbio
  #  bio.length > 100? bio[0..100] + "..." : bio
  #end

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
     self.works.each do |work|
       if (work.finishDate.year - work.startDate.year).to_i <= 1
         score += 2
       elsif (work.finishDate.year - work.startDate.year).to_i >= 2 && (work.finishDate.year - work.startDate.year).to_i <= 3
         score += 3
       elsif (work.finishDate.year - work.startDate.year).to_i >= 4 && (work.finishDate.year - work.startDate.year).to_i <= 5
         score += 4
       elsif (work.finishDate.year - work.startDate.year).to_i >= 5 && (work.finishDate.year - work.startDate.year).to_i <= 6
         score += 5
       elsif (work.finishDate.year - work.startDate.year).to_i > 7
         score += 10
       end

       workrole = work.position.downcase
       if workrole.include? "internship"
         score += 5
       elsif workrole.include? "senior"
         score += 10
       elsif workrole.include? "graduate"
         score += 15
       elsif workrole.include? "architect"
         score += 20
       elsif workrole.include? "engineer"
         score += 20
       elsif workrole.include? "manager"
         score += 20
       elsif workrole.include? "scientist"
         score += 20
       end

       splitDescription = work.workDescription.downcase.split(' ')
       keywords = ['teamwork', 'developed', 'enhanced', 'transformed', 'achieved','grew', 'introduced', 'project', 'awarded']
       splitDescription.select {|word| keywords.include?(word)}.each do |word|
         score += 2
       end

       workname = work.companyName
       topcompanies = CSV.read('lib/assets/topcampanies.csv',{encoding: "UTF-8", headers:true, header_converters: :symbol, converters: :all})
       hashed_topcompanies = topcompanies.map {|d| d.to_hash}
       hashed_topcompanies.select {|topcompanies| topcompanies[:companyname].include?(workname)}.each do |s|
         if s[:companyrank] <= 5
           score += 100
         elsif s[:companyrank] >= 6 && s[:companyrank] <=10
           score += 75
         elsif s[:companyrank] >= 11 && s[:companyrank] <=50
           score += 50
         elsif s[:companyrank] >=51 && s[:companyrank] <= 100
           score += 25
         elsif s[:companyrank] >=101 && s[:companyrank] <= 200
           score += 10
         elsif s[:companyrank] >= 201 && s[:companyrank] <=300
           score += 5
         end
       end

     end
   end

   if self.educations.present?
     score += 5 * self.educations.count
     self.educations.each do |e|
       universityname = e.university
       topuniversities = CSV.read('lib/assets/topuniversities.csv',{encoding: "UTF-8", headers:true, header_converters: :symbol, converters: :all})
       hashed_topuniversities = topuniversities.map {|d| d.to_hash}
       hashed_topuniversities.select {|topuniversities| topuniversities[:universityname].include?(universityname)}.each do |s|
         if s[:universityrank] <= 10
           score += 100
         elsif s[:universityrank] >= 11 && s[:universityrank] <=25
           score += 75
         elsif s[:universityrank] >= 26 && s[:universityrank] <=50
           score += 50
         elsif s[:universityrank] >=51 && s[:universityrank] <= 100
           score += 25
         elsif s[:universityrank] >=101 && s[:universityrank] <= 150
           score += 10
         end
       end
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

   if self.user.github_profile.present?
     score += 50
     if user.github_profile.followers > 3
       score += 1000
     end
     #no need to use count because public_repo is a number
     score += 5 * user.github_profile.public_repo

     Profile.crepos.each do |repo|
       if repo.watchers > 100
         score += 1000
       end
       if repo.forks > 100
         score += 1000
       end
       case repo.language.to_s.downcase
       when "ruby"
         score += 2
       when "objective-c"
         score += 2
       when "java"
         score += 2
       when "c++"
         score += 2
       when "python"
         score += 2
       when "javascript"
         score += 2
       when "php"
         score += 2
       end
       if repo.stargazers_count > 1
         score += 10
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

   if self.skills.present?
    score += 2 * skills.count
    self.skills.each do |skill|
      case skill.name.downcase
      when "ruby"
        score += 2
      when "objective-c"
        score += 2
      when "java"
        score += 2
      when "c++"
        score += 2
      when "python"
        score += 2
      when "javascript"
        score += 2
      when "php"
        score += 2
      end
    end
   end

   score
  end

end
