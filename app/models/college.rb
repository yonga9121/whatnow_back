class College
    include DefaultModel
    

    field :name
    belongs_to :city, index: true

    index({name: 1}, {unique: true})

    before_save :beautify_fields

    def beautify_fields
        self.name = self.name.capitalize
    end
end 