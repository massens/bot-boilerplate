class User < ApplicationRecord
	has_many :conversations, :messages
	validates_inclusion_of :client, :in => ["messenger", "telegram"], allow_nil: true

end
