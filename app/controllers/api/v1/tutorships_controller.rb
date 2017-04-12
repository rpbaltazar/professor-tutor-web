module Api::V1
  class TutorshipsController < ApiController
    # TODO: before action, authenticate user

    # If professor, returns his students
    # If student, returns his professor
    # For the serializer, its needed:
    #   - user id
    #   - display name
    def index
      if @current_user.is_professor?
        render json: @current_user.students
      else
        render json: @current_user.professor
      end
    end
  end
end
