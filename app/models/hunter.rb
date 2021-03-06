class Hunter
    include DefaultModel
    include Authenticable

    field :first_name
    field :last_name
    
    

    has_many :sessions, class_name: "Session"

    has_many :hunter_companies, class_name: "Hunter::HunterCompany"
    has_many :candidatures, class_name: "Candidature"


    def companies
        Company.where(:id.in => self.hunter_companies.pluck(:company_id))
    end 

    def default_company 
        hunter_company_default_id = self.hunter_companies.default&.company_id
        return Company.where(:id => hunter_company_default_id).first if hunter_company_default_id
        nil 
    end 

    def offers(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        Offer.where(:id.in => candidatures_query.pluck(:offer_id) )
    end 

    def candidatures(status_cd, limit = nil)
        candidatures_query = self.candidatures.where(:status_cd => status_cd)
        candidatures_query = candidatures_query.limit(limit) if limit
        User.where(:id.in => candidatures_query.pluck(:user_id) )
    end 
    
end 