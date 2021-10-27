class College
    include DefaultModel
    

    field :name
    field :formated_name
    
    belongs_to :city, index: true

    index({name: 1}, {unique: true})

    before_save :beautify_fields

    index({formated_name: "text"})

    def beautify_fields
        self.name = self.name.capitalize
        self.formated_name = self.name.downcase
    end

    def self.search(term:)
        College.collection.find(
            {"$text": { "$search": term } },
            {"score": {"$meta": "textScore"} }
        ).sort(score: { "$meta": "textScore" }).limit(30).map do |college|
            College.new college
        end 
    end 
    
end 