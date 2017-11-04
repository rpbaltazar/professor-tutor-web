module V1
  module StudyHour
    module Contract
      class MarkAsStarted < Reform::Form
        validate :unstarted_study_hour, if: :user_id
        validate :start_time_before_end_time

        def ensure_assigned_user_is_student
          user = ::User::Student.find_by id: user_id
          return unless user.nil?
          errors.add(:user_id, 'must be a student')
        end

        def start_time_before_end_time
          start_datetime = DateTime.parse(start_time)
          end_datetime = DateTime.parse(end_time)
          return if start_datetime < end_datetime
          errors.add(:start_time, 'must be before end time')
        end
      end
    end
  end
end
