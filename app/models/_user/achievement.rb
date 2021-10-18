class User::Achievement
    include DefaultModel
    
    field :name
    field :desc
    field :reference_date

    belongs_to :user, class_name: "User", index: true
end 