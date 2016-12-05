class User < ApplicationRecord
	validates_uniqueness_of :sender_id

end
