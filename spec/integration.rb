require 'minitest/autorun'
require 'rack'
require 'rack/test'
$LOAD_PATH.unshift('lib')
require 'ruby-pardot'

class PardotIntegrationTests < Minitest::Test
  include Rack::Test::Methods


  #functional test that creates a loan then flags the overview
  def setup
    @client = Pardot::Client.new ENV['PARDOT_EMAIL'], ENV['PARDOT_PASSWORD'], ENV['PARDOT_KEY']

    # will raise a Pardot::ResponseError if login fails
    # will raise a Pardot::NetError if the http call fails
    rs = @client.authenticate
    print rs
  end

  def test_send_email
    prospect = @client.prospects.read_by_email('etalley@assetavenue.com')
    rs = @client.emails.send_to_prospect(prospect['id'],{:campaign_id => prospect['campaign_id'],
                                                       :name => 'test',
                                                       :subject => 'test email',
                                                       :text_content => 'view the html email',
                                                       :html_content => '<div>Hello World!</div>',
                                                       :from_name => 'Asset Avenue',
                                                       :from_email => 'support@assetavenue.com',
                                                       :replyto_email => 'support@assetavenue.com',
                                                       } )

    puts rs
  end
end