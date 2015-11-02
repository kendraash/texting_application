class MessagesController < ApplicationController

  def new
  end

  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.from = "3013885205"
    if @message.save
      flash[:notice] = "Success!"
      redirect_to messages_path
    else
      render :new
    end
  end

  private

    def message_params
      params.require(:message).permit(:to, :from, :body)
    end

end
