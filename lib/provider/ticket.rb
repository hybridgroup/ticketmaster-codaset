module TicketMaster::Provider
  module Codaset
    # Ticket class for ticketmaster-codaset
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = CodasetAPI::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      alias_method :project_slug, :project_id
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def project_id
        self.prefix_options[:project_id]
      end
      
      def assignee
        @assignee ||= begin
          CodasetAPI::User.find(self[:assignee_id]).username
          rescue
          ''
          end
      end
      
    end
  end
end
