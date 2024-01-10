require 'redmine'

Redmine::Plugin.register :redmine_tidy_emails do
  name 'Redmine Tidy Emails'
  author 'Eugene Dubinin <eugend@commandprompt.com>'
  description 'This plugin allows to customize what to include in issue email notifications'
  version '0.1.2'
  author_url 'https://www.commandprompt.com'
  requires_redmine :version_or_higher => '5.0'

  settings default: {
      'remove_issue_edit_description': false,
      'remove_header_on_update': false
    }, partial: 'settings/redmine_tidy_emails'
end

Mailer.send(:include, RedmineTidyEmails::MailerPatch)
Mailer.layout 'mailer_alt'
