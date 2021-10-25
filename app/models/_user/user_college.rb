class User::UserCollege
    include DefaultModel

    as_enum :priority, K::PRIORITIES, field: {
        type: Integer, default: K::PRIORITIES[:low]
    }

    belongs_to :user, index: true
    belongs_to :college, class_name: "College", index: true

    index({priority_cd: 1})
    index({user_id: 1, college_id: 1})
    index({user_id: 1, college_id: 1, priority_cd: 1})
end 