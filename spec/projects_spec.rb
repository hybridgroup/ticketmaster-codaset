require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset::Project" do
  before(:all) do
    headers = {'Authorization' => 'OAuth 01234567890abcdef', 'Content-type' => 'application/x-www-form-urlencoded'}
    @project_id = 'my-project'
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/projects.xml', headers, fixture_for('projects'), 200
      mock.get '/my-project.xml', headers, fixture_for('my-project'), 200
      mock.post '/projects.xml', headers, fixture_for('projects'), 200
      mock.put '/my-project.xml', headers, '', 200
      mock.delete '/my-project.xml', headers, '', 200
    end
  end
  
  before(:each) do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
             ACCESS_TOKEN = {"access_token" => "01234567890abcdef", "refresh_token" => "abcdef01234567890", "expires_in" => "1209600", "username" => "anymoto"} 
             stub.post('/authorization/token') { [200, {'Content-type' => 'application/x-www-form-urlencoded'}, ACCESS_TOKEN.to_json] }
     end
     
     Faraday.default_connection = Faraday::Connection.new do |builder|
          builder.adapter :test, stubs
     end

    @ticketmaster = TicketMaster.new(:codaset, {:username => 'anymoto', :password => '000000', :client_id => '07f16ec71', :client_secret => '442fe0b16'} )
    @klass = TicketMaster::Provider::Codaset::Project
  end
  
  it "should be able to load all projects" do
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load projects from an array of ids" do
    @projects = @ticketmaster.projects([@project_id])
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == @project_id
  end
  
  it "should be able to load all projects from attributes" do
    @projects = @ticketmaster.projects(:id => @project_id)
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == @project_id
  end
  
  it "should be able to find a project" do
    @ticketmaster.project.should == @klass
    @ticketmaster.project.find(@project_id).should be_an_instance_of(@klass)
  end
  
  it "should be able to find a project by identifier" do
    @ticketmaster.project(@project_id).should be_an_instance_of(@klass)
    @ticketmaster.project(@project_id).id.should == @project_id
  end
  
  it "should be able to update and save a project" do
    @project = @ticketmaster.project(@project_id)
    @project.save.should == nil
    @project.update!(:short_name => 'some new name').should == true
    @project.short_name = 'this is a change'
    @project.save.should == true
  end
  
  it "should be able to create a project" do
    @project = @ticketmaster.project.create(:name => 'Project #1')
    @project.should be_an_instance_of(@klass)
  end
  
end