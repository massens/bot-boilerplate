class Message < ApplicationRecord
	belongs_to :conversation, optional: true
	belongs_to :user
end
