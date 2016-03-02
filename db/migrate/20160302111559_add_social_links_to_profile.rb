class AddSocialLinksToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :TwitterLink, :string
    add_column :profiles, :GithubLink, :string
    add_column :profiles, :StackLink, :string
    add_column :profiles, :DribbbleLink, :string
    add_column :profiles, :MediumLink, :string
  end
end
