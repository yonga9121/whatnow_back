module Api
    module Users
        class CollegesController < UsersController

            before_action :authenticate

            def index
                term = params[:term]
                colleges = []
                colleges = College.search(term: term) if !term.blank? && term.size > 2
                render_raw_sucess body: colleges, each_serializer: Api::CollegeSerializer
            end 


        end 
    end 
end 