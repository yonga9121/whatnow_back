class Api::VideoSerializer < ActiveModel::Serializer

    attributes :_id, :url, :name, :kind_cd
    
end 