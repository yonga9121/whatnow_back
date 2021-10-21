module Api
    module Users
        class CareersController < UsersController

            before_action :authenticate

            def index
                term = params[:term]
                careers = []
                careers = Career.search(term: term) if !term.blank? && term.size > 2
                render_raw_success body: careers, each_serializer: Api::CareerSerializer
            end 

        end 
    end 
end 