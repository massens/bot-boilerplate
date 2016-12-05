class TelegramController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    # msg = Message.create(
    #   text: text,
    #   sender: sender
    #   )

    # TelegramJob.perform_later msg
    render nothing: true, head: :ok
  end

  def sender
    {"id"=> params['webhook'][:message][:from][:id].to_s}
  end

  def text
    params[:webhook][:message][:text]
  end
end