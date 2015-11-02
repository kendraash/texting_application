class Message < ActiveRecord::Base
  validates_presence_of :to, :from, :body
  before_create :send_message

  private
    def send_message
      begin
        response = RestClient::Request.new(
          :method => :post,
          :url => 'https://api.twilio.com/2010-04-01/Accounts/AC4aaa4850e14a8a60494913179ecd44bd/Messages.json',
          :user => ENV['TWILIO_ACCOUNT_SID'],
          :password => ENV['TWILIO_AUTH_TOKEN'],
          :payload => { :Body => body,
                        :To => to,
                        :From => from
                        }
        ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end
  end
end
