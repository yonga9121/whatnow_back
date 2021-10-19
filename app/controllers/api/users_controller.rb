module Api
    class UsersController < ApiApplicationController
        
        def signup
            session = User.signup(
                email: signup_params[:email],
                password: signup_params[:password],
                password_confirmation: signup_params[:password_confirmation]
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

        private 

        def signin_params
            params.permit(:email, :password)
        end 

        def signup_params
            params.require(:user).permit(
                :email, 
                :password, 
                :password_confirmation
            )
        end 
        
    end 
end