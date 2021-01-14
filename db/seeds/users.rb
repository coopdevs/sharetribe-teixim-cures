marketplace = Community.first

UserService::API::Users.create_user(
  {
    username: 'troy',
    given_name: 'Troy',
    family_name: 'McClure',
    email: 'sharetribe@example.com',
    password: 'papapa22',
    locale: 'ca'
  },
  marketplace.id
)

UserService::API::Users.create_user(
  {
    username: 'buyer',
    given_name: 'Buyer',
    family_name: 'Perez',
    email: 'buyer@example.com',
    password: 'papapa22',
    locale: 'ca'
  },
  marketplace.id
)
