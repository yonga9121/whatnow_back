class Api::CandidatureSerializer < ActiveModel::Serializer

    attributes :id, :offer

    def id
        object&.id&.to_s
    end 

    def offer
        return nil if !object.offer
        ActiveModelSerializers::SerializableResource.new(
            object.offer, serializer: Api::OfferSerializer
        )
    end 
end 