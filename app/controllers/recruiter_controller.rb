class RecruiterController < ApplicationController

  def home
  end

  def favoriteDevelopers
    @recruiter = current_recruiter
    @favorites = @recruiter.favorite_profiles
  end

  def suggestedDevelopers
    profiles = Profile.all
    @suggestedDevelopers = profiles.map { |profile| profile.similar_profiles  }
  end

end
