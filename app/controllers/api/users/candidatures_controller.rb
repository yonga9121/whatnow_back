module Api
    module Users
        class CandidaturesController < UsersController

            before_action :authenticate

            def index
                raise Errors::InvalidParameter if( 
                    params[:status_cd].nil? || 
                    (   
                        params[:status_cd] && 
                        !K::CANDIDATE_STATUSES.values.include?(params[:status_cd].to_i)
                    )
                )
                candidatures = current_owner.candidatures.where(status_cd: params[:status_cd].to_i).paginate(
                    page: (params[:page] || 1).to_i, per_page: (params[:per_page] || 20).to_i
                )
                render_raw_success body: candidatures, each_serializer: Api::CandidatureSerializer
            end 

            def show
                candidature = current_owner.where(id: params[:id]).first
                raise Errors::InvalidParameter if !candidature 
                render_raw_success body: candidature, serializer: Api::CandidatureSerializer
            end
            
        end 
    end
end 