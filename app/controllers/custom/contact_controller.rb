class ContactController < ApplicationController
  skip_authorization_check

  invisible_captcha only: [:create], honeypot: :address

  def new
    render action: :contact
  end

  def create
    attachment_tmp_path = File.absolute_path(params[:attachment].tempfile) if params[:attachment].present?
    Mailer.contact('Nueva incidencia', contact_params, attachment_tmp_path).deliver_later
    redirect_to root_path, notice: t("pages.contact.success")
  end

  private
    def contact_params
      params.permit(:name, :email, :phone, :location, :description)
    end
end
