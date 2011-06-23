# ticketmaster-codaset

This is a provider for [ticketmaster](http://ticketrb.com). It provides interoperability with [Codaset](http://www.codaset.com).

# Usage and Examples

First we have to instantiate a new ticketmaster instance:

    codaset = TicketMaster.new(:codaset, {:username => "foo", :password => "bar", :client_id => "your_client_id", :client_secret => "your_client_secret"})

If you do not pass in username, password, client id and client secret you won't get any information.

== Finding Projects

You can find your own projects by doing:

    projects = codaset.projects # Will return all your projects
    projects = codaset.projects(['project1', 'project2']) # You must use your projects identifier 
    project = codaset.project('your_project') # Also use project identifier in here
	
== Finding Tickets

    tickets = project.tickets # All open issues
    ticket = project.ticket(<ticket_number>)

== Open Tickets
    
	ticket = project.ticket!({:title=> "New ticket", :description=> "Body for the very new ticket"})

== Update a ticket
	
	ticket.title = "New title"
	ticket.description =  "New Description"
	ticket.save

## Requirements

* rubygems (obviously)
* ticketmaster gem (latest version preferred)
* jeweler gem (only if you want to repackage and develop)
* OAuth2 gem

The ticketmaster gem and OAuth2 gem should automatically be installed during the installation of these gems if it is not already installed.

## Other Notes

Since this and the ticketmaster gem is still primarily a work-in-progress, minor changes may be incompatible with previous versions. Please be careful about using and updating this gem in production.

If you see or find any issues, feel free to open up an issue report.


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 [Hybrid Group](http://hybridgroup.com). See LICENSE for details.
