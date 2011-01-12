require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset" do
  it "should be able to instantiate a new instance" do
    @ticketmaster = TicketMaster.new(:codaset, {:username => 'anymoto', :password => '000000', :client_id => '07f16ec7', :client_secret => '442fe0b16'})
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Codaset)
  end
end
