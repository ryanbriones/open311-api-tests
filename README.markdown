# Chicago Open311 API Tests

A suite of tests to exercise the City of Chicago Open311 API Servers

## Setup

Ruby is required to run these tests. You can get Ruby on a Mac using [RVM](http://rvm.io) or on Windows using [RubyInstaller](http://rubyinstaller.org/).

Once you have a working Ruby and rubygems install, download the required gem dependencies using Bundler:

	# Shell/Terminal
	$ gem install bundler
	$ bundle install

Setup a `.env` file in the root of the project with your Chicago Open311 API Key and Base URL of site to test

	# .env
	OPEN311_API_KEY=SECRET
	OPEN311_BASE_URL=http://url.to.test/path/to/api/

You can also `export` these environment variables into your shell

	# Shell/Terminal Unix/Linux/Mac-specific
	$ export OPEN311_API_KEY=SECRET
	$ export OPEN311_BASE_URL=http://url.to.test/path/to/api/

The test suite with error and exit if you do not have OPEN311_API_KEY and OPEN311_BASE_URL environment variables setup.

## Running

Run tests using `rake`

	# Shell/Terminal
	$ rake test

The task `rake test` is actually aliased to the default task the following works as well

	# Shell/Terminal
	$ rake

Your results should look something like this:

	Feature: API `GET` Service

	  Scenario: API `GET` Service                           # features/api_get_service.feature:2
	    When I call the Service API via GET                 # features/step_definitions/api_get_service.rb:1
	    Then I should get back a list of service attributes # features/step_definitions/api_get_service.rb:5

	Feature: API `GET` Service List

	  Scenario: API `GET` Service List                                                # features/api_get_service_list.feature:2
	    When I call the Service List API via GET                                      # features/step_definitions/api_get_service_list.rb:1
	    Then I should get back a list of services and service codes available for use # features/step_definitions/api_get_service_list.rb:5

	Feature: API `POST` Request

	  Scenario: Creating a request and retrieving it          # features/api_post_request.feature:2
	    When I create a new request                           # features/step_definitions/api_post_request.rb:1
	    And I retrieve the Service ID using the request token # features/step_definitions/api_post_request.rb:18
	    Then I should be able to retrieve the request         # features/step_definitions/api_post_request.rb:23

	3 scenarios (3 passed)
	8 steps (8 passed)
	1m1.696s

## Support

* Ryan Briones <ryan.briones@cityofchicago.org>
