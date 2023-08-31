admin = User.create!(
    email: 'admin@example.com',
    password: 'password',
    role: 'admin'
  )
  Account.create!(user: admin, balance: 0)
  puts 'Admin user created.'
  