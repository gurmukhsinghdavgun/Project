class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :authenticate_person!, only: [:index, :show]
  impressionist actions: [:show], unique: [:session_hash]

  def index
    @search = Profile.search(params[:q])
    @profiles = @search.result(distinct: true).paginate(page: params[:page], per_page: params[:per_page])

    #if params[:skill]
    #  @profiles = Profile.tagged_with(params[:id])
  #  else
    #  @profiles = Profile.all
  #  end

  end

  def show
    impressionist(@profile)
    unless @profile.user.github_profile.nil?
      client = Octokit::Client.new(:access_token => @profile.user.github_profile.access_token)
      Profile.crepos = @repositories = client.repos
    end
    @joined = false
    if !current_recruiter.nil? && !current_recruiter.profiles.nil?
      @joined = current_recruiter.profiles.include?(@profile)
    end
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
      params.require(:profile).permit(:bio, :user_id, :name, :image, :location, :whatAmI, :phone, :experiance,
        :willingToRelocate, :score, :workAbroad, :salary, :UKauthorization, :TwitterLink, :GithubLink, :StackLink, :DribbbleLink, :MediumLink,
        :all_skills, educations_attributes: [:id, :university, :course, :finishdate, :degreetype, :level, :_destroy],
        portfolios_attributes: [:id, :description, :picture, :_destroy],
        works_attributes: [:id, :companyName, :position, :startDate, :finishDate, :workDescription, :_destroy],
        expertise_ids:[], city_ids:[] )
        #need to add images _destroy
    end
end
