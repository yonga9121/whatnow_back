module Api
    module Users
        class SkillsController < UsersController

            before_action :authenticate

            def index
                term = params[:term]
                skills = []
                skills = Skill.search(term: term) if !term.blank? && term.size > 2
                render_raw_sucess body: skills, each_serializer: Api::SkillSerializer
            end 

            def soft
                term = params[:term]
                skills = []
                skills = Skill.search(term: term, kind_cd: K::SKILL_KINDS[:soft]) if !term.blank? && term.size > 2
                render_raw_sucess body: skills, each_serializer: Api::SkillSerializer
            end 

        end
    end
end