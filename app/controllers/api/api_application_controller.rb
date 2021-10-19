class Api::ApiApplicationController < ApplicationController
    include SuccessHandler
    include ErrorHandler

    protected 

    def current_owner
        @current_owner ||= current_session.owner
    end 

    def current_session
        @current_session ||= Session.where(
            token: request.headers["X-WHATNOW-TOKEN"]
        ).first
    end 

    def authenticate
        raise Errors::Unauthorized if current_owner.nil?
    end 

end 