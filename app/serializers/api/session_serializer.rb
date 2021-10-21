module Api
    class SessionSerializer < ActiveModel::Serializer
        attributes :_id, :token

        def _id
            object&.id&.to_s
        end 
    end 
end 