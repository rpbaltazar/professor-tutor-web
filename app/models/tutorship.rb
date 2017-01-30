class Tutorship < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :professor, class_name: 'User', foreign_key: 'professor_id'
end
