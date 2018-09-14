module RedmineTidyEmails
    module IssuesHelperPatch
    unloadable

    def self.included(base)
      base.class_eval do
        alias_method_chain :email_issue_attributes, :cleanup
      end
    end

    def email_issue_attributes_with_cleanup(issue, user, html)
      items = email_issue_attributes_without_cleanup(issue, user, html)

      return items unless RedmineTidyEmails.settings['remove_empty_fields']

      if html
        items.reject! {|item| item =~ /\<strong\>.*:\ \<\/strong\>\z/ }
      else
        items.reject! {|item| item =~ /^.*:\ \z/ }
      end
      items
    end

    private

  end

  module MailerPatch
    def self.included(base)
      base.class_eval do
        alias_method_chain :issue_edit, :flags
      end
    end

   def issue_edit_with_flags(issue, to_users, cc_users)
      @skip_header = RedmineTidyEmails.settings['remove_header_on_update'] == 'true'
      @skip_body = RedmineTidyEmails.settings['remove_issue_edit_description'] == 'true'
      issue_edit_without_flags(issue, to_users, cc_users)
    end
  end

  def self.settings()
    Setting[:plugin_redmine_tidy_emails].blank? ? {} : Setting[:plugin_redmine_tidy_emails]
  end
end