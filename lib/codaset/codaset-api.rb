require 'rubygems'
require 'active_support'
require 'active_resource'
require 'oauth2'
require 'net/https'

# Ruby lib for working with the Codaset API's JSON interface.

# This library is a small wrapper around the REST interface.  You should read the docs at
# http://api.codaset.com
#

module CodasetAPI
  
  class Error < StandardError; end
  
  class << self
   attr_accessor :client_id, :client_secret
    def authenticate(username, password, client_id, client_secret)
      @username = username
      @password = password
     
      self::Base.user = username
      self::Base.password = password
      
      self.client_id = client_id
      self.client_secret = client_secret
      
      self.token = access_token(self)
     
    end
    
    def access_token(master)
      consumer = OAuth2::Client.new(master.client_id,
                                    master.client_secret,
                                    {:site => 
                                              {:url => master.site, 
                                               :ssl => {:verify => OpenSSL::SSL::VERIFY_NONE,
                                                        :ca_file => nil
                                                       },
                                               :adapter => :NetHttp
                                              },
                                    :authorize_url => '/authorization/token',
                                    :parse_json => true})
                                      
      response = consumer.request(:post, auth_url, {:grant_type => 'password', 
                                                    :client_id => master.client_id,
                                                    :client_secret => master.client_secret,
                                                    :username => master.user, 
                                                    :password => master.password},
                                                    'Content-Type' => 'application/x-www-form-urlencoded')

      OAuth2::AccessToken.new(consumer, response['access_token'])
    
    end
    
    def token=(value)
      resources.each do |klass|
        klass.headers['Authorization'] = 'OAuth ' + value.chomp!
      end
      @token = value
    end
    
    def resources
      @resources ||= []
    end
 
  end
    
  class Base < ActiveResource::Base
      self.format = :json
      self.site = 'https://api.codaset.com'
      def self.inherited(base)
        CodasetAPI.resources << base
        super
      end
  end
  
  # Find projects
  #
  #   CodasetAPI::Project.find(:all) # find all projects for the current account.
  #   CodasetAPI::Project.find(44)   # find individual project by ID
  #
  # Creating a Project
  #
  #   project = CodasetAPI::Project.new(:name => 'Ninja Whammy Jammy')
  #   project.save
  #   # => true
  #
  #
  # Updating a Project
  #
  #   project = CodasetAPI::Project.find(44)
  #   project.name = "Codaset Issues"
  #   project.public = false
  #   project.save
  #
  # Finding tickets
  # 
  #   project = CodasetAPI::Project.find(44)
  #   project.tickets
  #
  
  class Project < Base
    def tickets(options = {})
      Ticket.find(:all, :params => options.update(:project_slug => id))
    end  
  end
  
  # Find tickets
  #
  #  CodasetAPI::Ticket.find(:all, :params => { :project_id => 44 })
  #  CodasetAPI::Ticket.find(:all, :params => { :project_id => 44, :q => "status:closed" })
  #
  #  project = CodasetAPI::Project.find(44)
  #  project.tickets
  #  project.tickets(:q => "status:closed")
  #  project.tickets(:params => {:status => 'closed'})
  #
  #
  #
  
  class Ticket < Base
    self.site += '/:username/:project_slug/'
  end
    
end