class Api::Candidature::CompanySerializer < ActiveModel::Serializer

    attributes :id, :name, :logo_url

    def id 
        object&.id&.to_s
    end
end 