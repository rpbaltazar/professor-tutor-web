module Api::V1
  class UsersController < ApiController
    def index
      result = V1::User::Index.(params, current_user: @current_user)
      if result.success?
        render json: result['results'], status: :ok
      else
        render json: { 'errors': ['Account not set up yet'] },
               status: :unprocessable_entity
      end
    end

    def show
      # if professor, check if user is his student
      #   if not, return unauthorized
      #   if yes, return student schedule
      #   (phase two) If yes, return partial schedule
      # if student, check if user is self
      #   if not return unauthorized
      #   if yes, return schedule
      user_to_show = @current_user.find_user params[:id]
      if user_to_show
        render json: user_to_show.study_hours
      else
        render json: { error: "You can't see the requested user's study hours" },
               status: :unprocesseable_entity
      end
    end
  end
end
