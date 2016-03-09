class FavoriteProfilesController < ApplicationController
  before_action :set_profile

  def create
    if Favorite.create(favorited: @profile, recruiter: current_recruiter)
      redirect_to @profile, notice: 'Profile saved'
    else
      redirect_to @profile, alert: 'something went wrong'
    end
  end

  def destroy
    Favorite.where(favorited_id: @profile.id, recruiter_id: current_recruiter.id).first.destroy
    redirect_to @profile, notice: 'Profile removed from favorites'
  end

  private
  def set_profile
    @profile = Profile.find(params[:profile_id] || params[:id])
  end
end
