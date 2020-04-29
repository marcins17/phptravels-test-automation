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

And(/^I select departure date in "([^"]*)" days$/) do |arg|
  current_date = Date.today
  depart_date_list = get_date_and_return_departure_date(current_date, ("#{arg}").to_i)
  call_calendar = @browser.input(:name => "departure_date")
  call_calendar.click
  departure_date_input = @browser.div(:class => %w(datepicker active)).div(:data_date => depart_date_list[2].to_s,
                                                                           :data_month => depart_date_list[1].to_s,
                                                                           :data_year => depart_date_list[0].to_s)
  next_month_button = @browser.div(:class => %w(datepicker active)).div(:data_action => "next")
  insert_departure_date(departure_date_input, next_month_button)
end

And(/^I select "([^"]*)" adults$/) do |arg|
  #
  #add_button = @browser.div(:class => %w(col o2)).button(:class => %w(btn bootstrap-touchspin-up))
  #
  # I was trying with button implementation like above, but no action happened after click
  add_button = @browser.element(
      :xpath => "//*[@id='flights']/div/div/form/div/div[3]/div[3]/div/div/div[1]/div/div[2]/div/span/button[1]")
  adults = ("#{arg}".to_i - 1)
  adults.times do
    add_button.click
  end
end

And(/^I select "([^"]*)" children$/) do |arg|
  #
  #add_button = @browser.div(:class => %w(col o1)).button(:class => %w(btn bootstrap-touchspin-up))
  #
  # I was trying with button implementation like above, but no action happened after click
  #
  add_button = @browser.element(
      :xpath => "//*[@id='flights']/div/div/form/div/div[3]/div[3]/div/div/div[2]/div/div[2]/div/span/button[1]")
  children = "#{arg}".to_i
  children.times do
    add_button.click
  end
end

And(/^I submit data by clicking search button$/) do
  search_button = @browser.button(:type => "submit", :class => "btn-primary btn btn-block")
  search_button.fire_event("mousedown")
  search_button.fire_event("click")
end

Then(/^flight results should be displayed by price ascending$/) do
  sleep(4)

end
