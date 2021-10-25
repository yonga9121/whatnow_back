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


    class InvalidParameter < GenericError
        def initialize 
            super(
                error: 422,
                status: :unprocessable_entity,
                message: I18n.t("errors.invalid_parameter")
            )
        end 
    end 

    module SignupError
        class PasswordInvalid < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t("errors.signup.password_invalid")
                )
            end 
        end 

        class EmailInvalid < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t("errors.signup.email_invalid")
                )
            end 
        end 

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

    module UserError
        class SkillsMissing < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.user_error.skills_missing')
                )
            end
        end 

        class CareersMissing < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.user_error.careers_missing')
                )
            end
        end 

        class CollegesMissing < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.user_error.colleges_missing')
                )
            end
        end 

        class DescriptionVideoMissing < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.user_error.description_video_missing')
                )
            end
        end 

        class DegreeDateMissing < GenericError
            def initialize
                super(
                    error: 422,
                    status: :unprocessable_entity,
                    message: I18n.t('errors.user_error.degree_date_missing')
                )
            end
        end 
    end

end 