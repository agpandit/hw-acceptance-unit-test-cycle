Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	  Movie.create!(movie)
  end
end

Then /I should( not)? see the following movies: (.*)/ do |notsee, movies|
  movies.split(‘, ‘).each do |this_movie|
    if notsee
      step %Q{I should not see "#{this_movie}"}
    else
      step %Q{I should see "#{this_movie}"}
    end
  end
end

Then /I should see all the movies/ do
  Movie.all.each do |movie|
    step %Q{I should see "#{movie.title}"}
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regexp = /.*#{e1}.*#{e2}.*/m
  expect(page.body).to match(regexp)
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  step %Q{I should see "#{movie}"}
  step %Q{I should see "#{director}"}
end

Given /I have added "(.*)" with rating "(.*)"/ do |title, rating|
  steps %Q{
      Given I am on Create New Movie page
      When I fill in "Title" with "#{movie}"
      And I select "#{rating}" from "Rating"
      And I press "Save Changes"
    }
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(‘, ‘).each do |rating|
    if uncheck
      step %Q{I uncheck ratings_"#{rating}"}
    else
      step %Q{I check ratings_"#{rating}"}
    end
  end
end