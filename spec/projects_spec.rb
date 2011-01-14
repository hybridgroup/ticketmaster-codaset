require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Codaset::Project" do
  before(:all) do
    headers_get = {'Authorization' => 'OAuth 01234567890abcdef', 'Accept' => 'application/json'}  
    headers = {'Authorization' => 'OAuth 01234567890abcdef', 'Content-Type' => 'application/json'}              
    @project_id = 'my-project'
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/anymoto/projects.json', headers_get, fixture_for('projects'), 200
      mock.get '/anymoto/my-project.json', headers_get, fixture_for('my-project'), 200
      mock.post '/anymoto/projects.json?values[name]=New%20project', headers, '', 201
      mock.put '/anymoto/my-project.json?values[slug]=my-project&values[title]=My%20project&values[default_branch]=master&values[url]=http://codaset.com/anymoto/my-project&values[description]=This%20is%20my%20first%20project&values[state]=public', headers, '', 200
      mock.delete '/anymoto/my-project.json', headers, '', 200
    end

    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      ACCESS_TOKEN = { "access_token" => "01234567890abcdef", "refresh_token" => "01234567890abcdef", "expires_in" => 1209600, "username" => "anymoto" } 
      stub.post('/authorization/token') { [200, {}, ACCESS_TOKEN.to_json] }
    end

    new_method = Faraday::Connection.method(:new)
    Faraday::Connection.stub(:new) do |*args|
      connection = new_method.call(*args) do |builder|
        builder.adapter :test, stubs
      end
    end

    @ticketmaster = TicketMaster.new(:codaset, {:username => 'anymoto', :password => '000000', :client_id => '07f16ec71c324ab053885212ad65a6cc', :client_secret => '442fe0b16ff1143602e89ea923cbabc50'})
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
    @project.update!(:short_name => 'some new name').should == true
    @project.short_name = 'this is a change'
    @project.save.should == true
  end
  
  it "should be able to create a project" do
    @project = @ticketmaster.project.create(:name => 'New project')
    @project.should be_an_instance_of(@klass)
  end
  
end
