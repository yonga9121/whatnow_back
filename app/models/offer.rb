class Offer
    include DefaultModel
    include HasVideos

    field :name
    field :desc

    belongs_to :company, class_name: "Company", index: true
    has_many :offer_skills, class_name: "Offer::OfferSkill"
    has_many :candidatures, class_name: "Candidate"

    def skills
        Skill.where(:id.in => self.offer_skills.pluck(:skill_id))
    end 

    def users(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        User.where(:id.in => candidatures_query.pluck(:user_id) )
    end 


end 