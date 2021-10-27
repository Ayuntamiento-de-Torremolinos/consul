class VerificationController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_lock

  skip_authorization_check

  def show
    redirect_to next_step_path[:path], notice: next_step_path[:notice]
  end

  private

    def next_step_path(user = current_user)
      if user.organization?
        { path: account_path }
      elsif user.residence_verified?
        { path: account_path, notice: t("verification.redirect_notices.already_verified") }
      else
        { path: new_residence_path }
      end
    end
end
