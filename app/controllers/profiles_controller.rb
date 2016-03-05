class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  #below not working properly, look into nesting together
  #before_action :authenticate_recruiter!, only: [:index, :show]
  #this works better but still above requires user authenication
  #before_action :authenticate_user! || :authenticate_recruiter!

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = current_user.build_profile
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:bio, :user_id, :name, :location, :phone, :experiance,
        :willingToRelocate, :workAbroad, :salary, :UKauthorization, :TwitterLink, :GithubLink, :StackLink, :DribbbleLink, :MediumLink,
        :all_skills, educations_attributes: [:id, :university, :course, :finishdate, :level, :_destroy],
        portfolios_attributes: [:id, :description, :picture, :_destroy],
        works_attributes: [:id, :companyName, :position, :startDate, :finishDate, :workDescription, :_destroy],
        expertise_ids:[], city_ids:[] )
    end
end
