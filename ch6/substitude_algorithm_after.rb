def found_friend(people)
  people.select do |person|
    %w(Don John Kent).include? person
  end
end
