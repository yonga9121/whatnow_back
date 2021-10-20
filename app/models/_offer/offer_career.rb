class Offer::OfferCareer 
    include DefaultModel

    as_enum :priority, K::PRIORITIES , field: {
        type: Integer, default: K::PRIORITIES[:low]
    }

    belongs_to :offer, class_name: "Offer", index: true
    belongs_to :career, class_name: "Career", index: true
    
    index({offer_id: 1, career_id: 1})
end 