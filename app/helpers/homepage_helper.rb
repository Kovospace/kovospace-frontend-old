module HomepageHelper

    def skill_projects(skill)
        proj_parts = skill.portfolios.partition.each_with_index{ |el, i| i.even? }
        proj_parts.each_with_index do |side_group, i|
            res = ""
            side_group.each do |project|
                res << link_to(project) do
                    ("<span>" + project.title + "</span>").html_safe
                end
            end
            content_for "homepage_skills_projects_#{i.to_s}".to_sym, flush: true do
                res.html_safe
            end
        end
    end

end
