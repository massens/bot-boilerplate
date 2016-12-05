class User < ApplicationRecord
	has_many :conversations
	has_many :messages
	validates_inclusion_of :client, :in => ["messenger", "telegram"], allow_nil: true

	# Returns a ClientAdapter if it has one in self.client
	def get_client
		case self.client
		# when 'messenger'
			# return MessengerAdapter.instance 
		when 'telegram'
			return TelegramAdapter.instance 
		else
			puts 'No client!'
		end
	end

	def recipient
	  {"id"=> self.sender_id}
	end

end
