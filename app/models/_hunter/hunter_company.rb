class Hunter::HunterCompany
    include DefaultModel 

    field :default, default: false

    belongs_to :hunter, class_name: "Hunter", index: true
    belongs_to :company, class_name: "Company", index: true
    
    index({hunter_id: 1, company_id: 1})
    index({hunter_id: 1, company_id: 1, default: 1})

    def self.default
        where(default: true).first
    end

end 




# x = Hunter.last
# skills = Skill.where(:name.in => ["GO", "C++", "HTML", "CSS3", "JS"])
# soft_skills = Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Google"
# o1 = Offer.create! name: "Engineer Intern", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create!( career_id: c, priority_cd: 2)
# end 


# skills = Skill.where(:name.in => ["GO", "C++", "AWS EC2", "AWS Media Live"])
# soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Twitch"
# o1 = Offer.create! name: "Junior Software Engineer (DevOps) - Video Clients", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 



# skills = Skill.where(:name.in => ["GO", "C++", "Ruby", "HTML", "CSS3", "JS"])
# soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Twitch"
# o1 = Offer.create! name: "Twitch Intern", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 

# skills = Skill.where(:name.in => ["GO", "C++", "Ruby", "HTML", "CSS3", "JS", "JAVA", "Rust", "MySQL", "PostgreSQL", "MongoDB"])
# soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Facebook"
# o1 = Offer.create! name: "Facebook Intern", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 

# skills = Skill.where(:name.in => ["Android Development", "IOS Development", "C++"])
#  soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Uber"
# o1 = Offer.create! name: "Uber Intern", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 


# skills = Skill.where(:name.in => ["Flutter", "HTML", "CSS3", "JS", "Android Development", "IOS Development", "AngularJS"])
#  soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Picap"
# o1 = Offer.create! name: "Junior Front End developer", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 


# skills = Skill.where(:name.in => ["Ruby", "RubyOnRails", "GO"])
#  soft_skills= Skill.softs.all
# careers = Career.all
# company = Company.find_by name: "Picap"
# o1 = Offer.create! name: "Junior Back End developer", company_id: company.id, hunter_id: x
# skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 2)
# end 
# soft_skills.each do |s|
#     o1.offer_skills.create!( skill_id: s, priority_cd: 0)
# end 
# careers.each do |c|
#     o1.offer_careers.create! career_id: c, priority_cd: 2
# end 

