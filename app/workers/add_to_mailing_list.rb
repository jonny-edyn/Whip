class AddToMailingList

  @queue = :message_queue

  def self.perform(contact_email)


	require 'mailchimp'
	mailchimp = Mailchimp::API.new("#{ENV['MAILCHIMP_API_KEY']}")
	

	mailchimp.lists.subscribe("#{ENV['MAILCHIMP_LIST_ID']}", 
                   { "email" => "#{contact_email}"
                   })

  end

end