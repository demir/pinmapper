# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "'Pinmapper' <#{Rails.application.credentials.noreply_mail[:username]}>"
  layout 'mailer'
end
