Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Telegram callbacks
  # Development wehbook
  # https://api.telegram.org/bot286278199:AAFtI8nxS_qZydTRHYcbPVHrVVb9G_WeZtQ/setWebhook?url=https://6fe8f9ce.ngrok.io/webhooks/telegram
  post "/webhooks/telegram" => 'telegram#callback'
end
