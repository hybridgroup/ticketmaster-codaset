module TicketMaster::Provider
  module Codaset
    # Ticket class for ticketmaster-codaset
    # * project_id (prefix_options[:project_id])
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      attr_accessor :prefix_options
      API = CodasetAPI::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def project_id
        self.prefix_options[:project_id]
      end
      
    end
  end
end
