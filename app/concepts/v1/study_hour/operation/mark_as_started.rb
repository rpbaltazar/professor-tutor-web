module V1
  module StudyHour
    class MarkAsStarted < ProfessorTutorWeb::Operation
      step Model(::StudyHour, :find_by)
      step :model_not_found!
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step :check_unstarted_model!
      failure :study_hour_started!
      step :mark_as_started!
      step :save!

      def model_not_found!(options, **)
        options['result.model'] = ['Study hour not found']
      end

      def authorize!(current_user:, model:, **)
        current_user.student? && model.user == current_user
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end

      def check_unstarted_model!(model:, **)
        model.started_at.nil?
      end

      def study_hour_started!(model:, **)
        model.errors.add(:study_hour, 'is already started')
      end

      def mark_as_started!(model:, **)
        model.started_at = DateTime.now
      end

      def save!(model:, **)
        model.save
      end
    end
  end
end
