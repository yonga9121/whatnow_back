class Session
    include DefaultModel

    field :token
    
    belongs_to :owner, polymorphic: true, index: true

    before_create :setup_token

    def setup_token
        self.token = Digest::SHA2.new(256).hexdigest("#{Time.now.to_i}#{self.owner_id.to_s}")
    end 

end 