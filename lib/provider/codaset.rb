module TicketMaster::Provider
  # This is the Codaset Provider for ticketmaster
  module Codaset
    include TicketMaster::Provider::Base
    TICKET_API = Codaset::Ticket # The class to access the api's tickets
    PROJECT_API = Codaset::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Codaset.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:codaset, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.username.nil? or auth.password.nil?
        raise "Please provide username and password"
      end
      CodasetAPI.protocol = auth.protocol if auth.protocol?
      CodasetAPI.authenticate(auth.username, auth.password)
    end
    
    # declare needed overloaded methods here
    
  end
end


