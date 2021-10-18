class Hunter::HunterCompany
    include DefaultModel 

    field :default, default: false

    belongs_to :hunter, class_name: "Hunter", index: true
    belongs_to :company, class_name: "Company", index: true
    
    index({hunter_id: 1, company_id: 1})
    index({hunter_id: 1, company_id: 1, default: 1})

    def self.default
        where(default: true).first
    end

end 