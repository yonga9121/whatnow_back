class Offer
    include DefaultModel
    include HasVideos

    field :name
    field :formated_name
    
    field :desc
    field :num_of_candidatures_needed, default: 10

    as_enum :status, K::OFFER_STATUSES, field: {
        type: Integer, default: K::OFFER_STATUSES[:active]
    }

    belongs_to :company, class_name: "Company", index: true
    belongs_to :hunter, class_name: "Hunter", index: true
    has_many :offer_skills, class_name: "Offer::OfferSkill"
    has_many :offer_careers, class_name: "Offer::OfferCareer"
    has_many :candidatures, class_name: "Candidature"

    before_save :beautify_fields

    index({name: "text", formated_name: "text"})

    def beautify_fields
        self.name = self.name.capitalize
        self.formated_name = self.name.downcase
    end
    
    def skills
        Skill.where(:id.in => self.offer_skills.pluck(:skill_id))
    end 

    def users(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        User.where(:id.in => candidatures_query.pluck(:user_id) )
    end 

    def hunters(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        Hunter.where(:id.in => candidatures_query.pluck(:hunter_id) )
    end

end 