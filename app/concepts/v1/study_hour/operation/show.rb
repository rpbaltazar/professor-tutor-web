module V1
  module StudyHour
    class Show < ProfessorTutorWeb::Operation
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step :find_records

      def find_records(options, params:, current_user:, **)
        date = if params['date']
                 Date.parse(params['date'])
               else
                 Date.today
               end
        student = current_user.find_user(params["id"])
        options['results'] = student.study_hours.for_week(date)
      end

      def authorize!(current_user:, **)
        current_user.professor?
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end
