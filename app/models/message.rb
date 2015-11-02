class Message < ActiveRecord::Base
  validates_presence_of :to, :from, :body

end
