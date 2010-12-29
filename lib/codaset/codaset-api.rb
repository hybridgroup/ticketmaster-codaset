require 'rubygems'
require 'active_support'
require 'active_resource'
require 'oauth2'
require 'net/https'
require 'json'

# Ruby lib for working with the Codaset API's JSON interface.

# This library is a small wrapper around the REST interface.  You should read the docs at
# http://api.codaset.com
#

module CodasetAPI
  
  class Error < StandardError; end
  class << self
    attr_accessor :username, :password, :host_format, :domain_format, :protocol
    
    def authenticate(username, password)
      @username = username
      @password = password
      @site = 'https://api.codaset.com'
      
      self::Base.user = username
      self::Base.password = password
      self::Base.site = @site
      
      self.token = access_token(self)
     
    end
    
    def access_token(master)
      consumer = OAuth2::Client.new('07f16ec71c324ab053885212ad65a6cc8f34ac6e57ecb8412235ad406fc2c49c',
                                    '442fe0b16ff1143602e89ea923cbabc50342ab949a4b9c337905b9231236bdef',
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
                                                    :client_id => '07f16ec71c324ab053885212ad65a6cc8f34ac6e57ecb8412235ad406fc2c49c',
                                                    :client_secret => '442fe0b16ff1143602e89ea923cbabc50342ab949a4b9c337905b9231236bdef',
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

  self.host_format   = '%s://%s%s/'
  self.domain_format = '%s.api.codaset.com'
  self.protocol      = 'http' 
  
end
    
  class Base < ActiveResource::Base
      self.format = :json
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
      Ticket.find(:all, :params => options.update(:project_id => id))
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
    site_format << '/:username/projects/:project_id'
  end
    
end