class TelegramController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    user

    # msg = Message.create(text: text, sender: sender)

    # TelegramJob.perform_later msg
    render nothing: true, head: :ok
  end

  def sender
    {"id"=> params[:message][:from][:id].to_s}
  end

  def from
      params[:message][:from]
    end

  def text
    params[:message][:text]
  end

  def user
    @user ||= User.find_by(sender_id: sender['id']) || register_user
  end

  def register_user
    @user = User.first_or_create(sender_id: sender['id'])
    @user.update(first_name: from[:first_name], last_name: from[:last_name], client: 'telegram')
    @user.save
    @user
  end
end