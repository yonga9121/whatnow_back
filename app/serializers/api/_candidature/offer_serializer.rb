class Api::Candidature::OfferSerializer < ActiveModel::Serializer

    attributes :id, :name, :desc, :company, :desc_video_url

    def id 
        object&.id&.to_s
    end 

    def desc_video_url
        return nil if !object.desc_video
        object.desc_video.url
    end

    def company
        return nil if !object.company
        ActiveModelSerializers::SerializableResource.new(
            object.company, serializer: Api::Candidature::CompanySerializer
        )
    end 
end 