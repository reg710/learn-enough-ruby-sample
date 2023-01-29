class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com" # change to real if in prod
  layout "mailer"
end
