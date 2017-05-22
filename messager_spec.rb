require 'twilio-ruby'

class Messager
  def initialize(client = Twilio::REST::Client)
    @client = client
  end

  def send_sms(text)
    @client.account.messages.create(
      body: text,
      to: "05324523749",
      from: "8129382111"
    )
  end
end

# EXAMPLE 1: Does not test body
RSpec.describe Messager do
  describe '#send_sms' do
    it "thing" do
      client = double(:twilio_rest_client)
      messager = Messager.new(client)
      expect(client).to receive_message_chain(:account, :messages, :create)
      messager.send_sms("Woop")
    end
  end
end

# EXAMPLE 2: Does test body, but lots of cascading doubles
RSpec.describe Messager do
  describe '#send_sms' do
    it "thing again" do
      messages = double(:twilio_thing_with_messages_i_guess)
      account = double(:twilio_thing_with_an_account_why_not, messages: messages)
      client = double(:twilio_rest_client, account: account)
      messager = Messager.new(client)

      expect(messages).to receive(:create).with(body: "Woop", to: "05324523749", from: "8129382111")
      messager.send_sms("Woop")
    end
  end
end
