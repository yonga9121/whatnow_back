class Offer::OfferSkill
    include DefaultModel

    belongs_to :offer, class_name: "Offer", index: true
    belongs_to :skill, class_name: "Skill", index: true

    index({offer_id: 1, skill_id: 1})
end 