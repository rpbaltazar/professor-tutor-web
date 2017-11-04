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
        }, status: :unauthorized
      end
    end

    # NOTE: API endpoint for professor to delete
    # a study hour for one of his students
    def destroy
      if @study_hour
        if @study_hour.destroy
          render json: @study_hour.id
        else
          render json: { error: @study_hour.errors.full_messages },
                 status: :unprocesseable_entity
        end
      else
        render json: { error: 'There is no such record' },
               status: :unprocesseable_entity
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
