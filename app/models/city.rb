class City
    include DefaultModel
    
    field :name

    belongs_to :country, index: true
end 