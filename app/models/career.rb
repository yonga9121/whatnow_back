class Career
    include DefaultModel

    field :name
    
    belongs_to :college, index: true
    
end 