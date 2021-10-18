module DefaultModel
    extend ActiveSupport::Concern
    
    included do
        include Mongoid::Document
        include Mongoid::Timestamps
        include SimpleEnum::Mongoid
  
    
        index(created_at: 1)
        index(updated_at: 1)
    end
end 