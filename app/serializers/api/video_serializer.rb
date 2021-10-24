class Api::VideoSerializer < ActiveModel::Serializer

    attributes :id, :url, :name, :kind_cd
    
    def id
        object&.id&.to_s
    end 
end 