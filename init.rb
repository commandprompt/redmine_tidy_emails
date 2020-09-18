require 'redmine'

Redmine::Plugin.register :redmine_tidy_emails do
  name 'Redmine Tidy Emails'
  author 'Eugene Dubinin <eugend@commandprompt.com>'
  description 'This plugin allows to customize what to include in issue email notifications'
  version '0.1.1'
  author_url 'https://www.commandprompt.com'
  requires_redmine :version_or_higher => '3.0.x'

  settings default: {
      'remove_empty_fields': false,
      'remove_issue_edit_description': false,
      'remove_header_on_update': false
    }, partial: 'settings/redmine_tidy_emails'
end

prepare_block = Proc.new do
  IssuesHelper.send(:include, RedmineTidyEmails::IssuesHelperPatch)
  Mailer.send(:include, RedmineTidyEmails::MailerPatch)
  Mailer.layout 'mailer_alt'
end

if Rails.env.development?
  ((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare { prepare_block.call }
else
  prepare_block.call
end
