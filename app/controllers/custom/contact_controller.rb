class ContactController < ApplicationController
  skip_authorization_check

  invisible_captcha only: [:create], honeypot: :address

  def new
    render action: :contact
  end

  def create
    uploaded_file = {
      name: params[:attachment].original_filename,
      content: params[:attachment].read
    } unless params[:attachment].nil?

    Mailer.contact('Nueva incidencia', contact_params, uploaded_file).deliver_later

    redirect_to root_path, notice: t("pages.contact.success")
  end

  private
    def contact_params
      params.permit(:name, :email, :phone, :location, :description)
    end
end
