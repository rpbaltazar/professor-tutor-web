module V1
  module StudyHour
    class MarkAsFinished < ProfessorTutorWeb::Operation
      step Model(::StudyHour, :find_by)
      step :model_not_found!
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step :check_started_model!
      failure :study_hour_unstarted!
      step :check_unfinished_model!
      failure :study_hour_finished!
      step :mark_as_completed!
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

      def check_started_model!(model:, **)
        !model.started_at.nil?
      end

      def study_hour_unstarted!(model:, **)
        model.errors.add(:study_hour, 'has not been started yet')
      end

      def check_unfinished_model!(model:, **)
        model.completed_at.nil?
      end

      def study_hour_finished!(model:, **)
        model.errors.add(:study_hour, 'is already finished')
      end

      def mark_as_completed!(model:, **)
        model.completed_at = DateTime.now
      end

      def save!(model:, **)
        model.save
      end
    end
  end
end
