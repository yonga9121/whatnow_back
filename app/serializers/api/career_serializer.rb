class Api::CareerSerializer  < ActiveModel::Serializer
    attributes :id, :name, :college

    def id
        object&.id&.to_s
    end 
    
    def college
        return nil if !object.college
        ActiveModelSerializers::SerializableResource.new(
            object.college, serializer: Api::CollegeSerializer
        )
    end
end 