class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  TYPES = {
    professor: "Professor",
    student: "Student"
  }

  validates_presence_of :first_name, :last_name

  before_create do |user|
    user.api_key = user.generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

  def is_professor?
    type == TYPES[:professor]
  end

  def is_student?
    type == TYPES[:student]
  end
end
