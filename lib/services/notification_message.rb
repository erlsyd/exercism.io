require 'v1.0/helpers/fuzzy_time_helper'

class NotificationMessage < Message
  include Sinatra::FuzzyTimeHelper

  def initialize(options)
    @user = options.fetch(:user)
    @intercept_emails = options.fetch(:intercept_emails) { false }
    @site_root = options.fetch(:site_root) { 'http://exercism.io' }
  end

  def subject
    # "You have 5 notifications"
    "You have #{unread_notifications.count} #{'notification'.pluralize(notifications.count)}"
  end

  def recipient
    @user
  end

  def template_name
    'notifications'
  end

  def html_body
    ERB.new(template('notifications.html')).result binding
  end

  def ship
    return false unless send_email?
    Email.new(
      to: to,
      from: from_email,
      subject: full_subject,
      body: body,
      html_body: html_body,
      intercept_emails: intercept_emails?
    ).ship
    self
  end

  private

  def subject_pluralize(count, word)
    "#{count} #{word.pluralize(count)}"
  end

  def send_email?
    unread_notifications.count > 0
  end

  def pending_submissions
    pending_submissions = []
    @user.nitpicker_languages.each do |language|
      pending_submissions << Workload.new(@user, language, 'no-nits').submissions.limit(5)
    end
    pending_submissions.flatten
  end

  def unread_notifications
    @user.notifications.on_submissions.unread.recent.by_recency
  end

  def notifications
    unread_notifications.limit(5)
  end

  def truncated?
    unread_notifications.count > notifications.count
  end

  def from(user)
    user ? "from: #{user.username}" : ""
  end
end
