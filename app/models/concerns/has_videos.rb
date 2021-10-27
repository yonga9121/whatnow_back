module HasVideos
    extend ActiveSupport::Concern

    included do 
        has_many :videos, class_name: "Video", inverse_of: :owner
        
        def desc_video
            self.videos.descs.first
        end 
    
        def additional_videos
            self.videos.additionals
        end 
    end 
end