module V1
  module StudyHour
    class Destroy < ProfessorTutorWeb::Operation
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step Model(::StudyHour, :find_by)
      failure :model_not_found!
      step :destroy!

      def authorize!(current_user:, **)
        current_user.professor?
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end

      def model_not_found!(options, **)
        options['result.model'] = ['Study hour not found']
      end

      def destroy!(model:, **)
        model.destroy
      end
    end
  end
end
