class Career
    include DefaultModel

    field :name
    field :formated_name

    belongs_to :college, index: true
    belongs_to :city, index: true, optional: true
    belongs_to :country, index: true, optional: true

    before_create :setup_geo


    before_save :beautify_fields

    index({formated_name: "text"})

    def beautify_fields
        self.formated_name = self.name.downcase
    end

    def setup_geo
        self.city_id = self.college.city_id
        self.country_id = self.city.country_id
    end 

    def self.search(term:)
        Career.collection.find(
            {"$text": { "$search": term } },
            {"score": {"$meta": "textScore"} }
        ).sort(score: { "$meta": "textScore" }).limit(30).map do |career|
            Career.new career
        end 
    end 
    
end 