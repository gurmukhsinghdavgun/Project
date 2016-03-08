module ProfilesHelper
  def tag_links(skills)
    skills.split(",").map { |skill| link_to skill.strip, skill_path(skill.strip)}.join(", ")
  end
end
