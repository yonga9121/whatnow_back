class Candidate
    include DefaultModel

    field :closed_at
    
    as_enum :status, K::CANDIDATE_STATUSES, field: {
        type: Integer, default: K::CANDIDATE_STATUSES[:on_review]
    }

    belongs_to :user, class_name: "User", index: true
    belongs_to :offer, class_name: "Offer", index: true

    index({status_cd: 1})
    index({user_id: 1, offer_id: 1})
    index({user_id: 1, offer_id: 1, status_cd: 1})
end