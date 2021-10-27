require_dependency Rails.root.join('app', 'models', 'concerns', 'verification').to_s

module Verification
  extend ActiveSupport::Concern

  def verification_email_sent?
    true
  end

  def verification_sms_sent?
    true
  end

  def sms_verified?
    true
  end

  def verification_letter_sent?
    true
  end

  def level_three_verified?
    residence_verified?
  end

end
