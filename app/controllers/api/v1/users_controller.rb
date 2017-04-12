module Api::V1
  class UsersController < ApiController
    # TODO: before action, auth user
    def index
      render json: User.all
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
