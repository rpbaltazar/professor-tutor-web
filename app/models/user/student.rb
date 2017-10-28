class User::Student < User
  has_many :study_hours, dependent: :destroy, foreign_key: 'user_id'
  has_one :professor, through: :tutorship
  has_one :tutorship

  def find_user(user_id)
    return self if user_id == id
    nil
  end
end
