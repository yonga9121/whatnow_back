class Api::CareerSerializer  < ActiveModel::Serializer
    attributes :_id, :name, :college

    def college
        return nil if !object.college
        ActiveModelSerializers::SerializableResource.new(
            object.college, serializer: Api::CollegeSerializer
        )
    end
end 