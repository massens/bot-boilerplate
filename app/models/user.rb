class User < ApplicationRecord
	has_many :conversations
	has_many :messages
	validates_inclusion_of :client, :in => ["messenger", "telegram"], allow_nil: true

end
