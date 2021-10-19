module Api
    class SessionSerializer < ActiveModel::Serializer
        attributes :_id, :token
    end 
end 