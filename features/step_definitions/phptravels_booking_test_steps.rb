require_relative 'custom_methods.rb'
require 'date'

Given(/^I am on the booking site homepage/) do
  @browser.goto "https://www.phptravels.net/home"
end

When(/^I select "([^"]*)" section$/) do |arg|
  @browser.element(:href => /#{arg}/).click
end

And(/^I provide "([^"]*)" as a starting point$/) do |arg|
  @browser.div(:id => "s2id_location_from").click
  set_travel_point("#{arg}")
end

And(/^I provide "([^"]*)" as a destination point$/) do |arg|
  @browser.div(:id => "s2id_location_to").click
  set_travel_point("#{arg}")
end

And(/^I select date of departure in "([^"]*)" days$/) do |arg|
  current_date = Date.today
  days_to_departure = "#{arg}".to_i
  departure_date = (current_date + days_to_departure).to_s.split("-")
  departure_date_input = @browser.div(:class => %w(datepicker active)).div(
      :data_date => departure_date[2].sub(/^[0]*/,""),
      :data_month => (departure_date[1].sub(/^[0]*/,"").to_i - 1).to_s,
      :data_year => departure_date[0])
  next_month_button = @browser.div(:class => %w(datepicker active)).div(:data_action => "next")
  @browser.input(:name => "departure_date").click
  if departure_date_input.exists?
    click_on_element(departure_date_input)
  else
    click_on_element(next_month_button)
    departure_date_input.wait_until_present
    click_on_element(departure_date_input)
  end
end

And(/^I select "([^"]*)" adults$/) do |arg|
  add_button = @browser.div(:index => 1, :class => "col-4").button(:class => %w(bootstrap-touchspin-up))
  adults = ("#{arg}".to_i - 1)  # 1 adult is added by default
  adults.times do
    add_button.click
  end
end

And(/^I select "([^"]*)" children$/) do |arg|
  add_button = @browser.div(:index => 2, :class => "col-4").button(:class => %w(bootstrap-touchspin-up))
  children = "#{arg}".to_i
  children.times do
    add_button.click
  end
end

And(/^I submit by clicking on a search button$/) do
  search_button = @browser.button(:type => "submit", :class => "btn-primary btn btn-block")
  click_on_element(search_button)
end

Then(/^results should be displayed by price ascending and have NYC as starting point and Munich as destination$/) do
  starting_point = "New York"
  destination_point = "Munich"
  data = parse_data
  assert(data[0] == data[0].sort, "FAILURE: results are not sorted by price ascending")
  assert(data[1].all?{ |element| element == starting_point },
         "FAILURE: #{starting_point} is not visible in all results as a starting_point")
  assert(data[2].all?{ |element| element == destination_point },
         "FAILURE: #{destination_point} is not visible in all results as a destination point")
end

Given(/^from results I select a ticket with the fastest route$/) do
  fastest_route_index = find_index_of_fastest_route
  book_now_button = @browser.li(:index => fastest_route_index, :class => %w(all item)).button(:type => "submit")
  book_now_button.click
end

Then(/^ticket with the fastest route should be booked$/) do
  user = "user@phptravels.com"
  password = "demouser"
  # insert ticket data
  sleep(5)
end