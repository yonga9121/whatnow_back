module ErrorHandler
    extend ActiveSupport::Concern
  
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActionController::ParameterMissing do |e|
            missing_parameters(e)
        end
        rescue_from Mongoid::Errors::DocumentNotFound do |e|
            document_not_found(e)
        end
        rescue_from Mongo::Error::OperationFailure do |e|
            operation_failure(e)
        end
        rescue_from NoMethodError do |e|
            something_went_wrong(e)
        end
        rescue_from RangeError do |e|
            something_went_wrong(e)
        end
        rescue_from Mongoid::Errors::InvalidFind do |e|
            document_not_found(e)
        end
        rescue_from Mongoid::Errors::Validations do |e|
          validation_error(e)
        end
        rescue_from Errors::GenericError do |e|
          print_exception e 
          respond(e.status, e.message, e&.data)
        end
      end
    end
  
    private

    def print_exception(e)
        if Rails.env.development? || ENV['PRINT_EXCEPTIONS']
            puts "LOGGING EXCEPTION", "-"*250
            puts e.message
            e.backtrace.split(',').each do |m|
                puts m
            end
            puts "END LOGGING", "-"*250
        end 
    end 
  
    def respond(status, message, data)
        aux_response = { mssg: message }
        aux_response.merge!({data: data})
        # meta does not exist here
        #aux_response.merge!({meta: meta}) if meta
        render json: aux_response, status: status
    end
  
    def missing_parameters(e)
        print_exception(e)
        respond(:unprocessable_entity, I18n.t('errors.incomplete_params'), nil)
    end
  
    def document_not_found(e)
        print_exception(e)
        respond(:unprocessable_entity, I18n.t('errors.document_not_found'), nil)
    end

    def something_went_wrong(e)
        print_exception(e)
        respond(:unprocessable_entity, I18n.t('errors.something_went_wrong'), nil)
    end

    def operation_failure(e)
        print_exception(e)
        respond(:unprocessable_entity, I18n.t('errors.operation_failure'), nil)
    end 
  
    def validation_error(exception)
        print_exception(exception)
        raise Errors::ValidationError.new(
            validable: exception.document
        )
    rescue Errors::ValidationError => e
        respond(e.status, e.message, e&.data)
    end
  end
  