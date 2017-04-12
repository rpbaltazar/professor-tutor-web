class Professor < User
  has_many :students, through: :tutorships
  has_many :tutorships

  def find_user user_id
    begin
      student = students.find user_id
    rescue ActiveRecord::RecordNotFound => e
      student = nil
    end
    student
  end
end
