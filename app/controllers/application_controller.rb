class ApplicationController < ActionController::API
  private

  def _run_options(options)
    options.merge(current_user: current_user)
  end
end
