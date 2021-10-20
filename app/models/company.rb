class Company
    include DefaultModel

    field :name

    has_many :headquarters, class_name: "Company::Headquarter"

    def default_headquarter
        headquarters.main
    end 
    
end 