class Offer::OfferSkill
    include DefaultModel

    as_enum :priority, K::PRIORITIES , field: {
        type: Integer, default: K::PRIORITIES[:low]
    }

    belongs_to :offer, class_name: "Offer", index: true
    belongs_to :skill, class_name: "Skill", index: true

    index({offer_id: 1, skill_id: 1})
end 