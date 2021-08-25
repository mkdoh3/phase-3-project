require "faker"

Category.create(name: "to-do")
Category.create(name: "to-don't")


10.times do
    id = Category.first.id
    Task.create(text: Faker::Verb.base + " " + Faker::Name.name, category_id: id)
end

10.times do
    id = Category.last.id
    Task.create(text: Faker::Verb.base + " " + Faker::Name.name, category_id: id)
end
