class NotificationMailer < ApplicationMailer
  def daily_summary_email(user_name, user_email, summary_items)
    @name          = user_name
    @email         = user_email
    @notifications = summary_items

    @subject = 'Happening in your network'

    mail(to: @email, subject: @subject)
  end
end
