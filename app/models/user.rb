class User
    include DefaultModel
    include Authenticable
    include HasVideos

    field :desc
    field :degree_date
    field :looking_for_job, default: true
    

    belongs_to :college, index: true
    has_many :sessions, class_name: "Session"
    has_many :user_careers, class_name: "User::UserCareer"
    has_many :user_skills, class_name: "User::UserSkill"
    has_many :achievements, class_name: "Achievement"
    belongs_to :city, class_name: "City", index: true
    belongs_to :country, class_name: "Country", index: true
    has_many :candidatures, class_name: "Candidate"

    def self.looking_for_jobs
        where(looking_for_job: true)
    end 

    def careers(priority_cd)
        Career.where(:id.in => self.user_careers.where(
            priority_cd: priority_cd
        ).pluck(:career_id))
    end 
    
    def default_career
        user_career_default_id = self.user_careers.default&.career_id
        return Career.where(:id => user_career_default_id).first if user_career_default_id
        nil
    end 

    def skills(priority_cd)
        Skill.where(:id.in => self.user_skills.where(
            priority_cd: priority_cd
        ).pluck(:skill_id))
    end 

    def offers(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        Offer.where(:id.in => candidatures_query.pluck(:offer_id) )
    end 

    def hunters(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        Hunter.where(:id.in = > candidatures_query.pluck(:hunter_id) )
    end 

    def apply_to_offers
        candidate_offer_ids = self.candidatures.running.pluck(:offer_id)

        career_ids = self.user_careers.order_by(priority_cd: :desc).pluck(:career_id)
        skill_ids = self.user_skills.order_by(priority_cd: :desc).pluck(:career_id)

        offers = Offer.actives.any_of(
            {
                :id.in => Offer::OfferCareer.where(
                    :career_id.in => career_ids
                ).limit(10).pluck(:offer_id)
            },
            {
                :id.in => Offer::OfferSkill.where(
                    :skill_id.in => skill_ids
                ).limit(10).pluck(:offer_id)
            }
        ).where(
            :id.nin => candidate_offer_ids
        )

        new_candidatures_array = []
        aux_time = Time.now
        offers.each do |o|
            new_candidatures_array << {
                running: true, 
                status_cd: K::CANDIDATE_STATUSES[:on_review],
                user_id: self.id,
                offer_id: o.id,
                hunter_id: o.hunter_id,  
                created_at: aux_time,
                updated_at: aux_time
            }
        end 

        result = Candidate.collection.insert_many(new_candidatures_array)
        result&.inserted_ids
    end 

end 

