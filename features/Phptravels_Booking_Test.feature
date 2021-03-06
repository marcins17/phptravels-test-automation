Feature: PHPTRAVELS flight booking feature
  As a user I should be able to search for and book a flight ticket
  from NYC to Munich for 2 adults and 2 children with departure date in 14 days.

  Background:
    Given I am on the booking site homepage
    When I select "flights" section
    And I provide "NYC" as a starting point
    And I provide "Munich" as a destination point
    And I select date of departure in "14" days
    And I select "2" adults
    And I select "2" children
    And I submit by clicking on a search button

  Scenario: Results are displayed sorted by price (from lowest to highest)
    Then results should be displayed by price ascending and have NYC as starting point and Munich as destination

  Scenario: Book a flight using the fastest route
    Given from results I select a ticket with the fastest route
    #And booking summary displays correct information on the checkout page
    Then ticket with the fastest route should be booked
    
