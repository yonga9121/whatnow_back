class Api::SkillSerializer  < ActiveModel::Serializer
    attributes :id, :name, :desc
    
    def id
        object&.id&.to_s
    end 
end 