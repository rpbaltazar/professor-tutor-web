module Api::V1
  class StudyHoursController < ApiController
    before_action :find_study_hour, only: [:update, :destroy]

    def create
      result = V1::StudyHour::Create.(params)
      if result.success?
        render json: result['model'], status: :ok
      elsif result['result.policy.failure']
        render json: { 'errors': [] }, status: :unauthorized
      else
        render json: {
          'errors': result['contract.default'].errors.full_messages
        }, status: :unauthorized
      end
      # new_study_hour = StudyHour.new study_hour_params
      # if new_study_hour.save
      #   render json: new_study_hour
      # else
      #   render json: { error: new_study_hour.errors.full_messages },
      #          status: :unprocesseable_entity
      # end
    end

    # Both professors and students can update
    def update
    end

    # Only professors can destroy
    def destroy
      if @study_hour
        if @study_hour.destroy
          render json: @study_hour.id
        else
          render json: { error: @study_hour.errors.full_messages },
                 status: :unprocesseable_entity
        end
      else
        render json: { error: "There is no such record" },
               status: :unprocesseable_entity
      end
    end

    private

    def find_study_hour
      begin
        @study_hour = StudyHour.find params[:id]
      rescue ActiveRecord::RecordNotFound => e
        @study_hour = nil
      end
    end

    def study_hour_params
      params.require(:study_hour).permit([
                                           :start_time,
                                           :end_time,
                                           :description,
                                           :user_id
                                         ])
    end
  end
end
