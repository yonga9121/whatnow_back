class User
    include DefaultModel
    include Authenticable
    include HasVideos

    field :first_name
    field :last_name
    field :desc
    field :degree_date
    field :looking_for_job, default: true
    
    has_many :sessions, class_name: "Session"
    has_many :user_careers, class_name: "User::UserCareer"
    has_many :user_skills, class_name: "User::UserSkill"
    has_many :achievements, class_name: "Achievement"
    belongs_to :city, class_name: "City", index: true
    belongs_to :country, class_name: "Country", index: true
    has_many :candidatures, class_name: "Candidate"
    has_many :user_colleges, class_name: "User::College"

    def complete_profile(
        skills: [], 
        careers: [],
        colleges: [],
        desc_video: nil,
        additional_videos: [],
        degree_date: nil
    )
        if skills.any?
            self.user_skills.delete_all
            skills.each do |s|
                self.user_skills.create!(
                    skill_id: s.id,
                    priority_cd: K::PRIORITIES[:high]
                )
            end 
        else
            raise Errors::UserError::SkillsMissing
        end 

        if careers.any?
            self.user_careers.delete_all
            careers.each do |c|
                self.user_careers.create!(
                    career_id: c.id,
                    priority_cd: K::PRIORITIES[:high]
                )
            end 
        else
            raise Errors::UserError::CareersMissing
        end 
        
        if colleges.any?
            self.user_colleges.delete_all
            colleges.each do |c|
                self.user_colleges.create!(
                    college_id: c.id,
                    priority_cd: K::PRIORITIES[:high]
                )
            end 
        else
            raise Errors::UserError::CollegesMissing
        end 

        if desc_video
            self.desc_video.delete
            self.videos.descs.create!(
                url: desc_video.url,
                name: desc_video.name
            )
        else
            raise Errors::UserError::DescriptionVideoMissing
        end 
        
        if additional_videos.any?
            self.additional_videos.where(:name.in => additional_videos.pluck(:name)).delete_all
            additional_videos.each do |a|
                self.additional_videos.create!(
                    url: a.url,
                    name: a.name
                )
            end 
        end 
        
        if degree_date
            self.degree_date = degree_date
        else
            raise Errors::UserError::DegreeDateMissing
        end
        
        self.save!
    end

    def self.looking_for_jobs
        where(looking_for_job: true)
    end 

    def colleges
        College.where(:id.in => self.user_colleges.pluck(:college_id) )
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
        Hunter.where(:id.in => candidatures_query.pluck(:hunter_id) )
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
        ).limit(10)

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

