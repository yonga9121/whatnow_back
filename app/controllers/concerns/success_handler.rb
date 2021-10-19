module SuccessHandler
    extend ActiveSupport::Concern
    
    included do

        protected
        
        def render_success(
            body:,
            status: :ok,
            serializer: nil,
            each_serializer: nil,
            options: {}
        )
            if serializer.nil? && each_serializer.nil?
                response_body = {response: body}
                response_body.merge!(meta: meta) if meta
                render json: response_body, status: status 
            elsif serializer
                serializer_body = {
                    serializer: serializer
                }
                serializer_body.merge!(options) if options.any?
                response_body = {
                    response: ActiveModelSerializers::SerializableResource.new(
                        body,
                        serializer_body
                    )
                }
                response_body.merge!(meta: meta) if meta
                render json: response_body, status: status
            elsif each_serializer
                serializer_body = {
                    each_serializer: each_serializer
                }
                serializer_body.merge!(options) if options.any?
                response_body = {
                    response: ActiveModelSerializers::SerializableResource.new(
                        body,
                        serializer_body
                    )
                }
                response_body.merge!(meta: meta) if meta
                render json: response_body, status: status
            end
        end

        def render_raw_success(
            body:,
            status: :ok,
            serializer: nil,
            each_serializer: nil
        )
            if serializer.nil? && each_serializer.nil?
                render json: body, status: status 
            elsif serializer
                render json: body, status: status, serializer: serializer
            elsif each_serializer
                render json: body, status: status, each_serializer: each_serializer
            end
        end

    end
end 