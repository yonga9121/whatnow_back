class User::UserSkill
    include DefaultModel

    belongs_to :user, index: true
    belongs_to :skill, index: true

    index({user_id: 1, skill_id: 1})
end 