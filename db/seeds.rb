admin = User.create(email: 'admin@example.com', password: 'password', role: :admin)
p "Created admin user: #{admin.email}"
user = User.create(email: 'user@example.com', password: 'password', role: :user)
p "Created user: #{user.email}"
