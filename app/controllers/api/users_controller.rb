module Api
    class UsersController < ApiApplicationController
        
        before_action :authenticate, only: [:complete_profile, :profile]

        def signup
            session = User.signup(
                email: signup_params[:email],
                password: signup_params[:password],
                password_confirmation: signup_params[:password_confirmation]
            )
            session&.owner&.update(
                first_name: signup_params[:first_name],
                last_name: signup_params[:last_name],
            )
            render_raw_success body: session, serializer: SessionSerializer
        end 

        def signin
            session = User.signin(
                email: signin_params[:email],
                password: signin_params[:password]
            )
            render_raw_success body: session, serializer: SessionSerializer
        end 

        def profile
            render_raw_success body: user, serializer: Api::UserProfileSerializer
        end 

        def complete_profile
            skills = Skill.where(
                :id.in => (
                    complete_profile_params[:skill_ids] + 
                    complete_profile_params[:soft_skill_ids]
                )
            )
            careers = Career.where(:id.in => complete_profile_params[:career_ids])
            colleges = College.where(:id.in => complete_profile_params[:college_ids])
            desc_video = Video.new(
                url: complete_profile_params[:desc_video_url],
                user_id: currnet_owner.id
            )
            desc_video.desc!
            additional_videos = []
            complete_profile_params[:additional_videos].each do |x|
                additional_videos << Video.new(
                    name: x[:name],
                    url: x[:url],
                    user_id: currnet_owner.id,
                    kind_cd: K::VIDEO_KINDS[:additional]
                )
            end 
            achievements = []
            complete_profile_params[:achievements].each do |a|
                achievements << User::Achievement.new(
                    name: a[:name],
                    desc: a[:desc],
                    reference_date: a[:reference_date]
                )
            end 
            currnet_owner.complete_profile(
                skills:             skills,
                careers:            careers,
                colleges:           colleges,
                desc_video:         desc_video,
                additional_videos:  additional_videos,
                achievements:       achievements,
                degree_date:        complete_profile_params[:degree_date]
            )

            render_raw_success body: { success: true}
        end

        private 

        def signin_params
            params.permit(:email, :password)
        end 

        def signup_params
            params.require(:user).permit(
                :first_name,
                :last_name,
                :email, 
                :password, 
                :password_confirmation
            )
        end 

        def complete_profile_params
            params.permit(
                :skill_ids,
                :soft_skill_ids,
                :career_ids,
                :college_ids,
                :desc_video_url,
                :degree_date,
                achievements: [ :name, :desc, :reference_date ],
                additional_url: [ :url, :name ]
            )
        end 
        
    end 
end