module V1
  module User
    class Index < ProfessorTutorWeb::Operation
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step :find_records

      def find_records(options, current_user:, **)
        options['results'] = current_user.students
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
