module ProfessorTutorWeb
  class Operation < Trailblazer::Operation
    step Policy::Guard(:authenticate!, name: :authenticate)
    failure :unauthenticated!, fail_fast: true

    protected

    def authenticate!(options, **)
      return false unless @current_user
      options['current_user'] = @current_user
    end

    def unauthenticated!(options, **)
      options['result.policy.failure'] = :unauthenticated
    end
  end
end
