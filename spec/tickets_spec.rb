require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset::Ticket" do
  before(:all) do
    headers = {'Authorization' => 'OAuth 01234567890abcdef', 'Content-type' => 'application/x-www-form-urlencoded'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/my-project/tickets.xml', headers, fixture_for('tickets'), 200
      mock.get '/my-project/tickets/1.xml', headers, fixture_for('tickets/1'), 200
      mock.put '/my-project/tickets/1.xml', headers, '', 200
      mock.post '/my-project/tickets.xml', headers, '', 200
    end
    @project_id = 'my-project'
  end
  
  before(:each) do
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
     @ticket.save.should == nil
     @ticket.description = 'hello'
     @ticket.save.should == true
   end

   it "should be able to create a ticket" do
     @ticket = @project.ticket!(:title => 'Ticket #12', :description => 'Body')
     @ticket.should be_an_instance_of(@klass)
   end

 end
   