class RecruiterController < ApplicationController

  def home
  end

  def favoriteDevelopers
    @recruiter = current_recruiter
    @favorites = @recruiter.favorite_profiles
  end

end
