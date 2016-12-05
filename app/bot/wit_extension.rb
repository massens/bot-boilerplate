require 'wit'
require 'singleton'

class WitExtension
	include Singleton

	# Initialitza la classe
	def initialize
		access_token = ENV["WIT_TOKEN"]
		actions = {
			send: -> (request, response) {

				recipient = @conversation.user.recipient
				@adapter.send_response(recipient: recipient, response: response)

				puts "😊 [LOG] Sending '" + response['text'] + "' to: " + recipient
			},
			getForecast: -> (request) {
				context, entities = set_context(request)

				loc = first_entity_value(entities, 'location')
				if loc
				context['forecast'] = 'sunny'
				context.delete('missingLocation')
				else
				context['missingLocation'] = true
				context.delete('forecast')
				end

				@conversation.update(context: context)
				return context
			}
		}

		@client = Wit.new(access_token: access_token, actions: actions)
	end

	def client
		return @client
	end

	def set_conversation(conversation)
		@conversation = conversation	
	end

	def set_adapter(adapter)
		@adapter = adapter	
	end

	private

	def most_likely_entity_value(entities,entity)
		return nil unless entities.has_key? entity
		entities[entity].sort_by!{|entity| entity['confidence']}.reverse!
		val = entities[entity][0]['value']
		return nil if val.nil?
		return val.is_a?(Hash) ? val['value'] : val
	end

	def first_entity_value(entities, entity)
	  return nil unless entities.has_key? entity
	  val = entities[entity][0]['value']
	  return nil if val.nil?
	  return val.is_a?(Hash) ? val['value'] : val
	end

	# Sets context and entities
	def set_context(request)
		context = request['context']
		return context, request['entities']
	end

end