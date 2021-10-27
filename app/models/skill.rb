class Skill
    include DefaultModel

    field :name
    field :formated_name
    field :desc

    as_enum :kind, K::SKILL_KINDS, field: {
        type: Integer, default: K::SKILL_KINDS[:ability]
    }

    before_save :beautify_fields

    index({ formated_name: "text"})

    def beautify_fields
        self.formated_name = self.name.downcase
    end

    def self.search(term: , kind_cd: K::SKILL_KINDS[:ability])
        Skill.collection.find(
            {kind_cd: kind_cd, "$text": { "$search": term.downcase } },
            {"score": {"$meta": "textScore"} }
        ).sort(score: { "$meta": "textScore" }).limit(30).map do |skill|
            Skill.new skill
        end 
    end 

end