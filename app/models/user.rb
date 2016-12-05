class User < ApplicationRecord
	validates_inclusion_of :client, :in => ["messenger", "telegram"], allow_nil: true

end
