class Student < User
  has_many :study_hours, dependent: :destroy, foreign_key: 'user_id'
end
