class Api::UserProfileSerializer < ActiveModel::Serializer
    attributes  :id, 
                :first_name, 
                :last_name, 
                :desc, 
                :degree_date, 
                :careers, 
                :skills, 
                :soft_skills, 
                :desc_video, 
                :additional_videos
                :colleges


    def id
        object&.id&.to_s
    end 
    
    def careers
        ActiveModelSerializers::SerializableResource.new(
            object.careers, each_serializer: Api::CareerSerializer
        )
    end 

    def skills
        ActiveModelSerializers::SerializableResource.new(
            object.skills.abilities, each_serializer: Api::SkillSerializer
        )
    end 

    def soft_skills
        ActiveModelSerializers::SerializableResource.new(
            object.skills.softs, each_serializer: Api::SkillSerializer
        )
    end 

    def desc_video
        ActiveModelSerializers::SerializableResource.new(
            object.desc_video, serializer: Api::VideoSerializer
        )
    end

    def additional_videos
        ActiveModelSerializers::SerializableResource.new(
            object.additional_videos, each_serializer: Api::VideoSerializer
        )
    end 

    def colleges
        ActiveModelSerializers::SerializableResource.new(
            object.colleges, each_serializer: Api::CollegeSerializer
        )
    end 
end