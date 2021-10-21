class Api::SkillSerializer  < ActiveModel::Serializer
    attributes :_id, :name, :desc
    
    def _id
        object&.id&.to_s
    end 
end 