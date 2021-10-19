class User::UserSkill
    include DefaultModel

    as_enum :priority, K::PRIORITIES , field: {
        type: integer, default: K::PRIORITIES[:low]
    }

    belongs_to :user, index: true
    belongs_to :skill, index: true

    index({user_id: 1, skill_id: 1})
end 