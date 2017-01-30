class Professor < User
  has_many :students, through: :tutorships
  has_many :tutorships
end
