module Api
    class SessionSerializer < ActiveModel::Serializer
        attributes :id, :token

        def id
            object&.id&.to_s
        end 
    end 
end 