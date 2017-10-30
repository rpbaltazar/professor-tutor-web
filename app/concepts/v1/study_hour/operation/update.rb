module V1
  module StudyHour
    class Update < ProfessorTutorWeb::Operation
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step Model(::StudyHour, :find_by)
      step Trailblazer::Operation::Contract::Build(
        constant: StudyHour::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(
        key: :study_hour
      )
      step Trailblazer::Operation::Contract::Persist()

      def authorize!(current_user:, **)
        current_user.professor?
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end
