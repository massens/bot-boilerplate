class MessageJob < ApplicationJob
  queue_as :default

  def perform(*messages)
    # Do something later
  	messages.each do |message|
	    # Jamie is typing
	    user = message.user
	    adapter = user.get_client

	    # Show he is typing
	    adapter.typing(recipient: user.recipient)

	    # Find or create a conversation
	    @conversation = user.conversations.where(user_id: user.sender_id, active: 'true').first_or_create
	    msg.update(conversation_id: @conversation.id)

	    # # Put it in Wit 
	    # WitExtension.instance.set_conversation(@conversation)
	    # WitExtension.instance.set_adapter(adapter)

	    # # Run wit actions
	    # WitExtension.instance.client.run_actions(@conversation.uid, message.text, @conversation.context)
	end
  end
end
