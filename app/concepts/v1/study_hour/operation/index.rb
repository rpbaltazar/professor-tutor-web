module V1
  module StudyHour
    class Index < ProfessorTutorWeb::Operation
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step :find_records

      def find_records(options, params:, current_user:, **)
        date = if params['date']
                 Date.parse(params['date'])
               else
                 Date.today
               end
        options['results'] = current_user.study_hours.for_date(date)
      end

      def authorize!(current_user:, **)
        current_user.student?
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end
