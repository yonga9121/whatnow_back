class Api::VideoSerializer < ActiveModel::Serializer

    attributes :_id, :url, :name, :kind_cd
    
    def _id
        object&.id&.to_s
    end 
end 