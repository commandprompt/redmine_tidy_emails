require 'redmine'

Redmine::Plugin.register :redmine_remove_attachment_list_from_emails do
  name 'Redmine Remove Attachments List From Email plugin'
  author 'Eugene Dubinin <eugend@commandprompt.com>'
  description 'This plugin removes the attachment list and description (on edit only) from the issue update email nofications'
  version '0.1.1'
  author_url 'https://www.commandprompt.com'
  requires_redmine :version_or_higher => '3.0.x'
end
