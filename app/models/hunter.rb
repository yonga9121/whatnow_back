class Hunter
    include DefaultModel
    include Authenticable

    has_many :sessions, class_name: "Session"

    has_many :hunter_companies, class_name: "Hunter::HunterCompany"


    def companies
        Company.where(:id.in => self.hunter_companies.pluck(:company_id))
    end 

    def default_company 
        hunter_company_default_id = self.hunter_companies.default&.company_id
        return Company.where(:id => hunter_company_default_id).first if hunter_company_default_id
        nil 
    end 
    
end 