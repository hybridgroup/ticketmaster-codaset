require 'rubygems'
require 'active_support'
require 'active_resource'

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
      self::Base.user = username
      self::Base.password = password
    end
    
    def resources
      @resources ||= []
    end
    
  end
  
  self.host_format   = '%s://%s%s/'
  self.domain_format = '%s.api.codaset.com'
  self.protocol      = 'http' 
    
  class Base < ActiveResource::Base
      self.format = :json
      def self.inherited(base)
        CodasetAPI.resources << base
        class << base
          attr_accessor :site_format
        end
        base.site_format = '%s'
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
      Ticket.find(:all, :params => options.update(:project => id))
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
    site_format << '/projects/:project_id'
  end
  
  class User < Base
    site_format << '/:username'
  end
    
end