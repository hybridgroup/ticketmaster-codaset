module TicketMaster::Provider
  module Codaset
    # Ticket class for ticketmaster-codaset
    
     API = CodasetAPI::Ticket # The class to access the api's tickets
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      attr_accessor :prefix_options
     
      # declare needed overloaded methods here
      
      def initialize(*object)
        if object.first
          args = object
          object = args.shift
          project_id = args.shift
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:id => object.id,
                    :title => object.title,
                    :description => object.description,
                    :status => object.state,
                    :created_at => object.created_at,
                    :updated_at => object.updated_at,
                    :project_id => project_id}
          else
            hash = object
          end
          super hash
        end
      end
      
      def self.create(*options) 
          issue = API.new(options.first.merge!(:state => 'new', 
                                               :created_at => Time.now,
                                               :updated_at => Time.now))
          ticket = self.new issue
          issue.save
          ticket
      end
     
      def self.find_by_id(project_id, id)
          self.search(project_id, {'id' => id}).first
      end
      
      def self.search(project_id, options = {}, limit = 1000)
          tickets = API.find(:all, :params => {:slug => project_id}).collect { |ticket| self.new ticket, project_id }
          search_by_attribute(tickets, options, limit)
      end
      
      def self.find_by_attributes(project_id, attributes = {})
         self.search(project_id, attributes)
      end   
      
      def project_id
        self[:project_id]
      end
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def id
        self[:id].to_i
      end
      
      def status
        self[:status]
      end
      
      def title
        self[:title]
      end
      
      def description
        self[:description]
      end
      
      def comments
          warn 'Comments not supported. Perhaps you should leave feedback to request it?'
          []
      end

        #TODO?
      def comment
          warn 'Comments not supported. Perhaps you should leave feedback to request it?'
          nil
      end

        #TODO?
      def comment!
          warn 'Comments not supported. Perhaps you should leave feedback to request it?'
          []
      end
   
    end
  end
end
