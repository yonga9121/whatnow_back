class Video
    include DefaultModel

    field :url
    field :name
    
    as_enum :kind, K::VIDEO_KINDS, field: {
        type: Integer, default: K::VIDEO_KINDS[:desc]
    }
    
    belongs_to :owner, index: true, polymorphic: true 

    
    index({kind_cd: 1})
    index({owner_id: 1, kind_cd: 1})
end 