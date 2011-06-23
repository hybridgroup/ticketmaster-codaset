require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset" do

  before (:all) do
     stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      #ACCESS_TOKEN = { "access_token" => "01234567890abcdef", "refresh_token" => "01234567890abcdef", "expires_in" => 1209600, "username" => "anymoto" } 
      stub.post('/authorization/token') { [200, {}, ACCESS_TOKEN.to_json] }
    end

    new_method = Faraday::Connection.method(:new)
    Faraday::Connection.stub(:new) do |*args|
      connection = new_method.call(*args) do |builder|
        builder.adapter :test, stubs
      end
    end
    
    @ticketmaster = TicketMaster.new(:codaset, {:username => 'anymoto', :password => '000000', :client_id => '07f16ec7', :client_secret => '442fe0b16'})
  end

  it "should be able to instantiate a new instance" do
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Codaset)
  end

  it "should return true with valid authentication" do
    @ticketmaster.valid?.should be_true
  end
end
