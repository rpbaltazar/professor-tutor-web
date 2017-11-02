module ProfessorTutorWeb
  class Operation < Trailblazer::Operation
    step Policy::Guard(:authenticate!, name: :authenticate)
    failure :unauthenticated!, fail_fast: true

    protected

    def authenticate!(current_user:, **)
      current_user.present?
    end

    def unauthenticated!(options, **)
      options['result.policy.failure'] = :unauthenticated
    end
  end
end
