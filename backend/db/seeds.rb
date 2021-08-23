require "faker"

1000.times do
    Task.create(text: Faker::Verb.base + " " + Faker::Name.name, category_id: id)
end
