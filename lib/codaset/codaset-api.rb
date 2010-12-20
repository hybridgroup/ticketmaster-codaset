require 'rubygems'
require 'active_support'
require 'active_resource'

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
  
  class Project < Base
    def tickets(options = {})
      Ticket.find(:all, :params => options.update(:project => id))
    end  
  end
  
  class Ticket < Base
    site_format << '/projects/:project_id'
  end
  
  class UserIdentity < Base
    site_format << '/:username'
  end
    
end