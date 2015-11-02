class Message < ActiveRecord::Base
  validates_presence_of :to, :from, :body
  before_create :send_message

  private
    def send_message
      begin
        response = RestClient::Request.new(
          :method => :post,
          :url => 'https://api.twilio.com/2010-04-01/Accounts/AC4aaa4850e14a8a60494913179ecd44bd/Messages.json',
          :user => 'AC4aaa4850e14a8a60494913179ecd44bd',
          :password => '06439abc95cd81f97adc0c4a56ca2118',
          :payload => { :Body => body,
                        :To => to,
                        :From => from
                        }
        ).execute
    rescue
      false
    end
  end
end
