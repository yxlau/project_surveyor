# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Survey.destroy_all
Question.destroy_all
Option.destroy_all
Answer.destroy_all

puts "Seeding surveys..."
2.times do
  Survey.create!(title: "#{Faker::Book.title}", description: "#{Faker::Hipster.sentence}")
end

# questions
puts "Creating questions..."
12.times do
  Question.create!(survey_id: Survey.all.pluck(:id).sample, title: "Who said, '#{Faker::Hacker.say_something_smart}'?", multi: [true, false].sample, required: [true, false].sample, option_count: rand(1..6))
end

#options
puts "Creating options..."
Question.all.each do |q|
  q.option_count.times do |i|
    q.options.create!(value: "#{Faker::Pokemon.name}")
  end
end

puts "Creating blank survey..."
Survey.create!(title: 'A blank survey', description: 'A blank survey with a "blank" description')


puts "Filling in responses..."

[Survey.first, Survey.second].each do |s|
  4.times do
    r = s.responses.create
    s.questions.each do |q|
      a = r.answers.build(question_id: q.id)
      a.selections.build(option_id: q.options.pluck(:id).sample)
      a.save(validate: false)
    end
  end



end









puts "Done!"
