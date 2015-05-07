class AddToMailingList

  @queue = :message_queue

  def self.perform(contact_email)


	require 'mailchimp'
	mailchimp = Mailchimp::API.new("#{ENV['MAILCHIMP_API_KEY']}")
	
	subscribers = [{ "EMAIL" => { "email" => contact_email},
                 :EMAIL_TYPE => 'html',
              }]

    mailchimp.lists.batch_subscribe(ENV['MAILCHIMP_LIST_ID'], subscribers, false, false, false)

  end

end