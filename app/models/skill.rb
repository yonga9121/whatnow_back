class Skill
    include DefaultModel

    field :name
    field :formated_name
    field :desc

    as_enum :kind, K::SKILL_KINDS, field: {
        type: Integer, default: K::SKILL_KINDS[:ability]
    }

    before_save :beautify_fields

    def beautify_fields
        self.formated_name = self.name.downcase
    end

end