require 'redmine'

Redmine::Plugin.register :redmine_cleaner_notifications do
  name 'Redmine Cleaner Notifications'
  author 'Eugene Dubinin <eugend@commandprompt.com>'
  description 'This plugin allows to customize what to include in issue create/update email notifications'
  version '0.1.0'
  author_url 'https://www.commandprompt.com'
  requires_redmine :version_or_higher => '3.0.x'

  settings default: {
      'remove_empty_fields': false,
      'settings_remove_issue_edit_description': false
    }, partial: 'settings/redmine_cleaner_notifications'
end

prepare_block = Proc.new do
  IssuesHelper.send(:include, RedmineCleanerNotifications::IssuesHelperPatch)
end

if Rails.env.development?
  ActionDispatch::Reloader.to_prepare { prepare_block.call }
else
  prepare_block.call
end
