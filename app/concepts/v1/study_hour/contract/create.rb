module V1
  module StudyHour
    module Contract
      class Create < Reform::Form
        property :start_time
        property :end_time
        property :description
        property :user_id

        validates :start_time, :end_time, :description, :user_id, presence: true
        validate :ensure_assigned_user_is_student, if: :user_id

        def ensure_assigned_user_is_student
          user = User::Student.find_by id: user_id
          return unless user.nil?
          errors.add(:user_id, 'must be a student')
        end
      end
    end
  end
end
