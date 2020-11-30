marketplace = MarketplaceService.create(
  marketplace_name: 'sharetribe',
  marketplace_type: 'product',
  marketplace_country: 'ES',
  marketplace_language: 'es'
)
marketplace.locales << 'ca'
marketplace.save!

user = UserService::API::Users.create_user(
  {
    given_name: 'Troy',
    family_name: 'McClure',
    email: 'sharetribe@example.com',
    password: 'papapa22',
    locale: 'es'
  },
  marketplace.id
)
user = user.data

auth_token = UserService::API::AuthTokens.create_login_token(user[:id])
auth_token = AuthToken.first
user_token = auth_token[:token]
url = URLUtils.append_query_param(
  marketplace.full_domain(with_protocol: true), "auth", user_token
)

NumericField.create(
  community: Community.first,
  min: 1,
  max: 999,
  categories: [Category.first],
  search_filter: false,
  names: [
    CustomFieldName.new(
      value: 'Cantidad mínima a solicitar',
      locale: 'es'
    ),
  ]
)

NumericField.create(
  community: Community.first,
  min: 1,
  max: 999,
  categories: [Category.first],
  search_filter: false,
  names: [
    CustomFieldName.new(
      value: 'Cantidad disponible',
      locale: 'es'
    ),
  ]
)

Rake::Task['stripe:enable'].invoke

# Enable customizable footer. Note it also needs external_plan_service_in_use
# set to true.
PlanService::Store::Plan::PlanModel.create(
  community_id: marketplace.id,
  status: "active",
  features: {"whitelabel"=>true, "admin_email"=>true, "footer"=>true},
  expires_at: Time.current + 20.years
)

require Rails.root.join('db/seeds/categories.rb')

puts "\n\e[33mYou can now navigate to your markeplace at #{url}"
