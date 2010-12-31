module TicketMaster::Provider
  module Codaset
    # Project class for ticketmaster-codaset
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = Codaset::Project # The class to access the api's projects
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
      
      def name
        self[:title]
      end
      
      def ticket!(*options)
        options[0].merge!(:project_id => id) if options.first.is_a?(Hash)
        self.class.parent::Ticket.create(*options)
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


