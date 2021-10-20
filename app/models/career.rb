class Career
    include DefaultModel

    field :name
    
    belongs_to :college, index: true
    belongs_to :city, index: true, optional: true
    belongs_to :country, index: true, optional: true

    before_create :setup_geo

    def setup_geo
        self.city_id = self.college.city_id
        self.country_id = self.city.country_id
    end 
    
end 