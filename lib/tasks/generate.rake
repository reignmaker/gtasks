namespace :generate do
  desc "Generate fake users"
  task users: :environment do
    p "Generating fake users..."
    10.times do
      u = User.create(email: Faker::Internet.email, password: Faker::Internet.password)
      p "Created user #{u.email}."
    end
  end

  desc "Generate fake tasks"
  task tasks: :environment do
    p "Generating fake tasks..."
    users = User.pluck(:id)
    20.times do
      t = Task.create(name: Faker::Lorem.sentence(1),
                      description: Faker::Lorem.paragraph, user_id: users.sample,
                      state: Task.states.keys.sample)
      p "Created task ##{t.id}-#{t.name}"
    end
  end

end
