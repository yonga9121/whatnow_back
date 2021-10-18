module Errors

    class GenericError < StandardError
        attr_reader :status, :error, :message, :data

        def initialize(error: nil, status: nil, message: nil, data: nil )
            @error = error || 422
            @status = status || :unprocessable_entity
            @message = message || I18n.t('errors.something_went_wrong')
            @data = data || []
        end
    end 


    module SignupError
        class EmailAlreadyExist < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.signup.email_already_exist')
                )
            end 
        end

        class PasswordDoNotMatch < GenericError
            def initialize 
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.signup.password_do_not_match')
                )
            end 
        end 

    end 

    module AuthenticationError
        class Invalid < GenericError
            def initialize 
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.authentication.invalid')
                )
            end 
        end 
 
    end 

end 