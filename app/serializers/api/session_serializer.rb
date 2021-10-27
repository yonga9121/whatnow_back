module Api
    class SessionSerializer < ActiveModel::Serializer
        attributes :id, :token, :owner_id

        def id
            object&.id&.to_s
        end 

        def owner_id
            object&.owner_id&.to_s
        end 
    end 
end 