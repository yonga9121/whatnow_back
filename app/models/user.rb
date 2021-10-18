class User
    include DefaultModel
    include Authenticable
    include HasVideos

    field :desc
    field :degree_date


    belongs_to :college, index: true
    has_many :sessions, class_name: "Session"
    has_many :user_careers, class_name: "User::UserCareer"
    has_many :user_skills, class_name: "User::UserSkill"
    has_many :achievement, class_name: "Achievement"
    belongs_to :city, class_name: "City", index: true
    belongs_to :country, class_name: "Country", index: true
    has_many :candidatures, class_name: "Candidate"

    def careers
        Career.where(:id.in => self.user_careers.pluck(:career_id))
    end 
    
    def default_career
        user_career_default_id = self.user_careers.default&.career_id
        return Career.where(:id => user_career_default_id).first if user_career_default_id
        nil
    end 

    def skills
        Skill.where(:id.in => self.user_skills.pluck(:skill_id))
    end 

    def offers(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        Offer.where(:id.in => candidatures_query.pluck(:offer_id) )
    end 
    

end 

