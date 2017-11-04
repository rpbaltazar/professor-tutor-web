module Api::V1
  class StudyHoursController < ApiController
    before_action :find_study_hour, only: [:destroy]

    # NOTE: API endpoint for professor to create a study hour
    # for one of his students
    def create
      result = V1::StudyHour::Create.(params, current_user: @current_user)
      if result.success?
        render json: result['model'], status: :created
      elsif result['result.policy.failure']
        render json: { 'errors': [] }, status: :unauthorized
      else
        render json: {
          'errors': result['contract.default'].errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    # NOTE: API endpoint for professor to update
    # a study hour for one of his students
    def update
      result = V1::StudyHour::Update.(params, current_user: @current_user)
      if result.success?
        render json: result['model'], status: :ok
      elsif result['result.policy.failure']
        render json: { 'errors': [] }, status: :unauthorized
      else
        render json: {
          'errors': result['contract.default'].errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    # NOTE: API endpoint for professor to delete
    # a study hour for one of his students
    def destroy
      result = V1::StudyHour::Destroy.(params, current_user: @current_user)
      if result.success?
        render json: result['model'].id, status: :ok
      elsif result['result.policy.failure']
        render json: { 'errors': [] }, status: :unauthorized
      else
        errors = result['model']&.errors&.full_messages || result['result.model']
        render json: { 'errors': errors }, status: :unprocessable_entity
      end
    end

    # NOTE: API endpoint for student to mark the study hour
    # as started
    def mark_as_started
    end

    # NOTE: API endpoint for student to mark the study hour
    # as finished
    def mark_as_finished
    end

    private

    def find_study_hour
      @study_hour = StudyHour.find_by(id: params[:id])
    end

    def study_hour_params
      params.require(:study_hour)
            .permit(%i[start_time end_time description user_id])
    end
  end
end
