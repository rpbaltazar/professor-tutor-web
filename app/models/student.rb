class Student < User
  has_many :study_hours, dependent: :destroy, foreign_key: 'user_id'
  has_one :professor, through: :tutorship
  has_one :tutorship

  def find_user user_id
    if user_id == self.id
      self
    else
      nil
    end
  end
end
