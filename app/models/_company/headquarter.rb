class Company::Headquarter
    include DefaultModel
    
    field :main, default: true
    field :address
    field :secondary_address

    belongs_to :company, class_name: "Company", index: true

    index({main: 1})
    index({company_id: 1, main: 1})

    def self.main
        where(main: true).first
    end 
end 