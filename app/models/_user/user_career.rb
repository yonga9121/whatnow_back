class User::UserCareer
    include DefaultModel

    field :default, default: false

    as_enum :priority, K::PRIORITIES , field: {
        type: Integer, default: K::PRIORITIES[:low]
    }

    belongs_to :user, index: true
    belongs_to :career, index: true

    index({user_id: 1, career_id: 1})
    index({user_id: 1, career_id: 1, default: 1})

    def self.default
        where(default: true).first
    end 
end 