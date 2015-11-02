require 'rails_helper'

describe Message, :vcr => true do
  it { should validate_presence_of :to }
  it { should validate_presence_of :from }
  it { should validate_presence_of :body }

  it "doesn't save the message if twilio gives an error" do
    message = Message.new(:body => 'hi', :to => '5039463641', :from => '1111111')
    message.save.should be false
  end

  it 'adds an error if the from number is invalid' do
    message = Message.new(:body => 'hi', :to => '5039463641', :from => '1111111')
    message.save
    message.errors.messages[:base].should eq ["The 'From' number 1111111 is not a valid phone number or shortcode."]
  end

  it 'adds an error if the to number is invalid' do
    message = Message.new(:body => 'hi', :to => '111111', :from => '3013885205')
    message.save
    message.errors.messages[:base].should eq ["The 'To' number 111111 is not a valid phone number."]
  end
end
