module TicketMaster::Provider
  module Codaset
    # Project class for ticketmaster-codaset
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = CodasetAPI::Project # The class to access the api's projects
      # declare needed overloaded methods here
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def initialize(*options)
        super(*options)
      end
      
      def id
        self[:slug]
      end
      
      def identifier
          self[:identifier]
      end
      
      def name
        self[:title]
      end
      
      def ticket!(*options)
        options[0].merge!(:slug => slug) if options.first.is_a?(Hash)
        provider_parent(self.class)::Ticket.create(*options)
      end
      
      def tickets(*options)
        begin 
        if options.first.is_a? Hash
          #options[0].merge!(:params => {:slug => slug})
          super(*options)
        elsif options.empty?
          tickets = CodasetAPI::Ticket.find(:all, :params => {:slug => slug}).collect { |ticket| TicketMaster::Provider::Codaset::Ticket.new ticket }
        else
          super(*options)
        end
        rescue
          []
        end
      end
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

    end
  end
end


