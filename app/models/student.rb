class Student < User
  has_many :study_hours, dependent: :destroy, foreign_key: 'user_id'
  has_one :professor, through: :tutorship
  has_one :tutorship
end
