require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset::Ticket" do
  before(:all) do
    headers_get = {'Authorization' => 'OAuth 01234567890abcdef', 'Accept' => 'application/json'}
    headers = {'Authorization' => 'OAuth 01234567890abcdef', 'Content-Type' => 'application/json'}
    @project_id = 'my-project'
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/anymoto/my-project.json', headers_get, fixture_for('my-project'), 200
      mock.get '/anymoto/my-project/tickets.json', headers_get, fixture_for('tickets'), 200
      mock.get '/anymoto/my-project/tickets/1.json', headers_get, fixture_for('tickets/1'), 200
      mock.put '/anymoto/my-project/tickets/1?values[title]=First%20ticket&values[description]=new%20ticket%20description', headers, '', 200
      mock.post '/anymoto/my-project/tickets.json?values[title]=Ticket%20%2312&values[description]=Body&values[state]=new', headers, fixture_for('new-ticket'), 200
    end
  
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
  
     @ticketmaster = TicketMaster.new(:codaset, {:username => 'anymoto', :password => '000000', :client_id => '07f16ec71c324ab053885212ad65a6cc', :client_secret => '442fe0b16ff1143602e89ea923cbabc50'})
     @project = @ticketmaster.project(@project_id)
     @klass = TicketMaster::Provider::Codaset::Ticket
   end
   
   it "should be able to load all tickets" do
     @project.tickets.should be_an_instance_of(Array)
     @project.tickets.first.should be_an_instance_of(@klass)
   end

   it "should be able to load all tickets based on an array of ids" do
     @tickets = @project.tickets([1])
     @tickets.should be_an_instance_of(Array)
     @tickets.first.should be_an_instance_of(@klass)
     @tickets.first.id.should == 1
   end

   it "should be able to load all tickets based on attributes" do
     @tickets = @project.tickets(:id => 1)
     @tickets.should be_an_instance_of(Array)
     @tickets.first.should be_an_instance_of(@klass)
     @tickets.first.id.should == 1
   end

   it "should return the ticket class" do
     @project.ticket.should == @klass
   end

   it "should be able to load a single ticket" do
     @ticket = @project.ticket(1)
     @ticket.should be_an_instance_of(@klass)
     @ticket.id.should == 1
   end

   it "should be able to load a single ticket based on attributes" do
     @ticket = @project.ticket(:id => 1)
     @ticket.should be_an_instance_of(@klass)
     @ticket.id.should == 1
   end

   it "should be able to update and save a ticket" do
     @ticket = @project.ticket(1)
     @ticket.description = 'new ticket description'
     @ticket.save.should == true
   end

   it "should be able to create a ticket" do
     @ticket = @project.ticket!(:title => 'Ticket #12', :description => 'Body')
     @ticket.should be_an_instance_of(@klass)
   end

 end
   