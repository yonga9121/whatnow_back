class Skill
    include DefaultModel

    field :name
    field :desc

    as_enum :kind, K::SKILL_KINDS, field: {
        type: Integer, default: K::SKILL_KINDS[:ability]
    }

end