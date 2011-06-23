module TicketMaster::Provider
  # This is the Codaset Provider for ticketmaster
  module Codaset
    include TicketMaster::Provider::Base
    TICKET_API = CodasetAPI::Ticket # The class to access the api's tickets
    PROJECT_API = CodasetAPI::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Codaset.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:codaset, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    
    # Client Id and Client Secret: get these values once you register your app on http://api.codaset.com/apps
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.username.nil? or auth.password.nil? or auth.client_id.nil? or auth.client_secret.nil?
        raise "Please provide username, password, client id and client secret"
      end
      CodasetAPI.account = auth.username
      CodasetAPI.authenticate(auth.username, auth.password, auth.client_id, auth.client_secret)
    end
    
    # declare needed overloaded methods here
    #
    def valid?
      begin
        PROJECT_API.find(:first)
        true
      rescue
        false
      end
    end
    
  end
end


