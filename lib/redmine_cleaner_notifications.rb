module RedmineCleanerNotifications
    module IssuesHelperPatch
    unloadable

    def self.included(base)
      base.class_eval do
        alias_method_chain :email_issue_attributes, :cleanup
      end
    end

    def email_issue_attributes_with_cleanup(issue, user, html)
      items = email_issue_attributes_without_cleanup(issue, user, html)

      return items unless RedmineCleanerNotifications.settings['remove_empty_fields']

      if html
        items.reject! {|item| item =~ /\<strong\>.*:\ \<\/strong\>\z/ }
      else
        items.reject! {|item| item =~ /^.*:\ \z/ }
      end
      items
    end

    private

  end
  def self.settings()
    Setting[:plugin_redmine_cleaner_notifications].blank? ? {} : Setting[:plugin_redmine_cleaner_notifications]
  end
end