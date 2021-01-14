marketplace = MarketplaceService.create(
  marketplace_name: 'sharetribe',
  marketplace_type: 'product',
  marketplace_country: 'ES',
  marketplace_language: 'es',
  show_location: false
)
marketplace.locales << 'ca'
marketplace.save!

require Rails.root.join('db/seeds/users.rb')
require Rails.root.join('db/seeds/listings.rb')
require Rails.root.join('db/seeds/categories.rb')

user = Person.find_by(given_name: 'Troy')
auth_token = UserService::API::AuthTokens.create_login_token(user.id)
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

puts "\n\e[33mYou can now navigate to your markeplace at #{url}"
