module Authenticable
    extend ActiveSupport::Concern
    
    included do 

        attr_reader :password
        attr_reader :password_confirmation
        
        field :email
        field :password_digest

        before_save :setup_digest

        def authenticate(password)
            self.class.authenticate(
                email: self.email, 
                password: password
            )            
        end 

        def setup_digest
            if self.persisted?
                if !self.password.blank?
                    validate_password
                    self.password_digest = self.class.digest(self.password)
                end 
            else
                validate_password
                self.password_digest = self.class.digest(self.password)
            end 
        end 

        private 

        def validate_password
            if self.password.blank? || self.password_confirmation.blank?
                raise Errors::SignupError::PasswordDoNotMatch
            end

            if self.password != self.password_confirmation
                raise Errors::SignupError::PasswordDoNotMatch
            end
        end 

    end 

    module ClassMethods

        def signup(email:, password:, password_confirmation:)
            raise Errors::SignupError::EmailAlreadyExist if where(email: email).any?
            aux = new(
                email: email, 
                password: password, 
                password_confirmation: password_confirmation
            )
            aux.save!
            signin(email: email, password: password)
        end 

        def signin(email: , password: )
            aux = authenticate( 
                email: email, 
                password: password
            ) 
            session = aux.sessions.create!
            session
        end 

        def authenticate(email:, password:)
            aux = where(
                email: email, 
                password_digest: digest(password)
            ).first
            raise Errors::AuthenticationError::Invalid if !aux
            aux
        end 
        
        private 

        def digest(password)
            Digest::SHA2.new(256).hexdigest(password)
        end 
    end 

end 