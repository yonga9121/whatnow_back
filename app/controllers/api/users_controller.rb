module Api
    class UsersController < ApiApplicationController
        
        before_action :authenticate, only: [:complete_profile, :profile]

        def signup

            raise Errors::SignupError::EmailInvalid if signup_params[:email].blank?
            raise Errors::SignupError::PasswordInvalid if signup_params[:password].blank?
            raise Errors::SignupError::PasswordInvalid if signup_params[:password_confirmation].blank?
            session = User.signup(
                email: signup_params[:email],
                password: signup_params[:password],
                password_confirmation: signup_params[:password_confirmation]
            )
            session&.owner&.update(
                first_name: signup_params[:first_name],
                last_name: signup_params[:last_name],
                phone_number: signin_params[:phone_number],
                phone_code: (signin_params[:phone_code] || "+57")
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
                owner: current_owner
            )
            desc_video.desc!
            additional_videos = []
            complete_profile_params[:additional_videos].each do |x|
                additional_videos << Video.new(
                    name: x[:name],
                    url: x[:url],
                    owner: current_owner,
                    kind_cd: K::VIDEO_KINDS[:additional]
                )
            end if complete_profile_params[:additional_videos]
            achievements = []
            complete_profile_params[:achievements].each do |a|
                achievements << User::Achievement.new(
                    name: a[:name],
                    desc: a[:desc],
                    reference_date: a[:reference_date]
                )
            end if complete_profile_params[:achievements]

            current_owner.completex_profile(
                complete_profile_params[:degree_date],
                desc_video,
                skills,
                careers,
                colleges,
                additional_videos,
                achievements
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
                :phone_number,
                :phone_code,
                :email, 
                :password, 
                :password_confirmation
            )
        end 

        def complete_profile_params
            params.permit(
                :desc_video_url,
                :degree_date,
                skill_ids: [],
                soft_skill_ids: [],
                college_ids: [],
                career_ids: [],
                achievements: [ :name, :desc, :reference_date ],
                additional_videos: [ :url, :name ]
            )
        end 
        
    end 
end