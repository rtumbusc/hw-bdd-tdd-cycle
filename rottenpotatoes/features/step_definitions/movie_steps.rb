# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
    step %Q{I should see "#{title}"}
    step %Q{I should see "#{director}"}
end
# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body).to match(/#{e1}.*#{e2}/m)
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
 if uncheck == "un"
   rating_list.split(', ').each {|i| step %{I uncheck "ratings_#{i}"}}
 else
   rating_list.split(', ').each {|i| step %{I check "ratings_#{i}"}}
 end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
end

Then /I should see all the movies/ do
  page.should have_css("#movies tbody tr",count: Movie.count)
  # Make sure that all the movies in the app are visible in the table
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each do |field|
      check("ratings["+field.strip+"]")
    end
  else
    rating_list.split(',').each do |field|
      uncheck("ratings["+field.strip+"]")
    end
  end
end