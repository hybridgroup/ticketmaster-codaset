module TicketMaster::Provider
  module Codaset
    # Ticket class for ticketmaster-codaset
    # * project_id (prefix_options[:project_id])
    
     API = CodasetAPI::Ticket # The class to access the api's tickets
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      attr_accessor :prefix_options
     
      # declare needed overloaded methods here
      
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:title=> object.title,
                    :description => object.description}
          else
            hash = object
          end
          super hash
        end
      end
      
      def self.create(*options)
          puts 'create'
          issue = API.new(options.first.merge!(:state => 'new'))
          puts issue
          ticket = self.new issue
          issue.save
          ticket
      end
      
      def self.find_by_id(project_id, ticket_id)
        self.new API.find(ticket_id)
      end

      def self.find_by_attributes(project_id, attributes = {})
        tickets = API.find(:all, build_attributes(project_id, attributes))
        tickets.collect { |issue| self.new issue }
      end
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def slug
        self.prefix_options[:slug]
      end
      
      def id
        id
      end
      
      #TODO?
      def comments
        warn 'Not supported. Perhaps you should leave feedback to request it?'
        []
      end

      #TODO?
      def comment
        warn 'Not supported. Perhaps you should leave feedback to request it?'
        nil
      end

      #TODO?
      def comment!
        warn 'Not supported. Perhaps you should leave feedback to request it?'
        []
      end
      
    end
  end
end
