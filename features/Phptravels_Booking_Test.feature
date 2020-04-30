Feature: PHPTRAVELS flight booking feature
  As a user I should be able to search for and book a flight ticket
  from NYC to Munich for 2 adults and 2 children with departure date in 14 days.

  #Background:
  Scenario: Flight results should be sorted by price ascending based on given ticket data
    Given I am on the booking site homepage
    When I select "flights" section
    And I provide "NYC" as a starting point
    And I provide "Munich" as a destination point
    And I select departure date in "14" days
    And I select "2" adults
    And I select "2" children
    And I submit data by clicking search button
    Then flight results should be displayed by price ascending
    #actually only results are displayed, sorting verification not implemented yet

  #TODO
  #Scenario: Results are displayed sorted by price (from lowest to highest)
    #Then flight results should be displayed by price ascending
  
  #Scenario: Booking summary displays correct information on the checkout page
    #Then booking summary displays correct information
  
  #Scenario: Book a flight using the fastest route
    #Then ticket with the fastest route should be booked
    
