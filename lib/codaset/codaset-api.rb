require 'rubygems'
require 'active_support'
require 'active_resource'
require 'oauth2'

module CodasetAPI
  
  class Error < StandardError; end
  class << self
    
    def authenticate(username, password)
      @username = username
      @password = password
      self::Base.user = username
      self::Base.password = password
    end
    
    def resources
      @resources ||= []
    end
    
    def client
      OAuth2::Client.new('07f16ec71c324ab053885212ad65a6cc8f34ac6e57ecb8412235ad406fc2c49c',
                         '442fe0b16ff1143602e89ea923cbabc50342ab949a4b9c337905b9231236bdef',
                         :site => 'https://api.codaset.com/')
    end
    
  end    
  
  
    
  class Base < ActiveResource::Base
      self.site   = 'https://api.codaset.com/'
      self.format = :json
      
      def self.inherited(base)
        CodasetAPI.resources << base
        super
      end
    
  end
  
  class Project < Base
    def tickets(options = {})
      Ticket.find(:all, :params => options.update(:project => id))
    end  
  end
  
  class Ticket < Base
    self.site += ':username/:project_slug/tickets/:id'
  end
  
  class UserIdentity < Base
    self.site += ':username/'
  end
    
  
end