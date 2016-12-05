require "telegram/bot"
# Development wehbook
# https://api.telegram.org/bot286278199:AAFtI8nxS_qZydTRHYcbPVHrVVb9G_WeZtQ/setWebhook?url=https://6fe8f9ce.ngrok.io/webhooks/telegram

# Production webhook
# https://api.telegram.org/bot164573002:AAHx7mTRdwvcSPOnI3QcdYGcMRzhVZ_zyqw/setWebhook?url=https://jamieanswers.herokuapp.com/webhooks/telegram_1e937d775c61400884e1357aef6e0adb

class TelegramAdapter
	include Singleton

	def initialize
		@bot = ::Telegram::Bot::Api.new('286278199:AAFtI8nxS_qZydTRHYcbPVHrVVb9G_WeZtQ')
	end
	# Send response
	def send_response(recipient:, response:)
		if quick_answers = response['quickreplies']	
			send_quick_answers(recipient: recipient, message: response['text'], quick_answers: quick_answers)
		else
			send_text(recipient: recipient, message: response['text'])
		end
	end


	# sends wolfram pod
	def send_wolfram_pod(recipient:, pod:)
		send_text(recipient: recipient, message:pod[0])	
		if pod[1]["plainText"].empty?
			begin
				send_photo(recipient: recipient, photo_url: pod[1]["img"])
			rescue Exception => e
				puts 'Error with Photo, wolfram sent an invalid url'			
				puts pod
			end
		else
			send_text(recipient: recipient, message: pod[1]["plainText"])
		end
	end

	# Send message
	def send_text(recipient:, message:)
		chat_id = recipient['id']
		@bot.sendMessage(chat_id: chat_id, text: message)
	end

	# Sends photo
	def send_photo(recipient:, photo_url:)
	chat_id = recipient['id']
	@bot.sendPhoto(chat_id: chat_id, photo: photo_url)
	end

	# send message with quick answers
	def send_quick_answers(recipient:, message:, quick_answers:)
		quickreplies = []
		quick_answers.each{|msg| quickreplies << msg}
		chat_id = recipient['id']

		answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: quickreplies, one_time_keyboard: true)
		@bot.send_message(chat_id: chat_id, text: message, reply_markup: answers)
	end

	# # displays in messenger that he is typing
	def typing(recipient:)
		# TODO Fill the method TelegramAdapter#Typing
		# Bot.deliver(recipient: recipient, sender_action:'TYPING_ON')
		chat_id = recipient['id']
		@bot.sendChatAction(chat_id: chat_id, action: 'typing')	
	end

	# Returns the type of the adapter
	def type
		return 'telegram'	
	end

end